//
//  Todos.swift
//  TrainingTCA
//
//  Created by sakiyamaK on 2025/10/05.
//

import ComposableArchitecture
import SwiftUI

enum Filter: LocalizedStringKey, CaseIterable, Hashable {
    case all = "All"
    case active = "Active"
    case completed = "Completed"
}

@Reducer
struct Todos {

    @ObservableState
    struct State: Equatable {
        var editMode: EditMode = .inactive
        var filter: Filter = .all
        /*
         IdentifiedArrayOf<Element> = IdentifiedArray<Element.ID, Element>
         idを持った要素の配列みたいな感じ
         内部的にはOrderedDictionaryみたい
         */
        var todos: IdentifiedArrayOf<Todo.State> = []

        var filteredTodos: IdentifiedArrayOf<Todo.State> {
            switch filter {
            case .active:
                return self.todos.filter { !$0.isComplete }
            case .all:
                return self.todos
            case .completed:
                return self.todos.filter(\.isComplete)
            }
        }
    }

    enum Action: BindableAction, Sendable {
        case addTodoButtonTapped
        case binding(BindingAction<State>)
        case clearCompletedButtonTapped
        case delete(IndexSet)
        case move(IndexSet, Int)
        case sortCompletedTodos
        /*
         IdentifiedActionOf<Reducer>はIdentifiedAction<Reducer.State.ID, Reducer.Action>の書き換え
         子のstoreのactionを受け取るために用意する
         */
        case todos(IdentifiedActionOf<Todo>)
  }

    /*
     @Dependencyで外部依存のパラメータを渡せる
     ViewとReducerに関わらないものは全てDependency
     */
    @Dependency(\.continuousClock) var clock
    @Dependency(\.uuid) var uuid

    private enum CancelID { case todoCompletion }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .addTodoButtonTapped:
                state.todos.insert(Todo.State(id: self.uuid()), at: 0)
                return .none

            case .binding:
                return .none

            case .clearCompletedButtonTapped:
                state.todos.removeAll(where: \.isComplete)
                return .none

            case let .delete(indexSet):
                let filteredTodos = state.filteredTodos
                for index in indexSet {
                    state.todos.remove(id: filteredTodos[index].id)
                }
                return .none

            case var .move(source, destination):
                if state.filter == .completed {
                    source = IndexSet(
                        source
                            .map { state.filteredTodos[$0] }
                            .compactMap { state.todos.index(id: $0.id) }
                    )
                    destination =
                    (destination < state.filteredTodos.endIndex
                     ? state.todos.index(id: state.filteredTodos[destination].id)
                     : state.todos.endIndex)
                    ?? destination
                }

                state.todos.move(fromOffsets: source, toOffset: destination)

                return Effect.run { send in
                    try await self.clock.sleep(for: .milliseconds(100))
                    await send(.sortCompletedTodos)
                }

            case .sortCompletedTodos:
                // isCompleteを後ろにする
                state.todos.sort { $1.isComplete && !$0.isComplete }
                return .none

            case .todos(.element(id: _, action: .binding(\.isComplete))):
            /*
             ↑を省略しないで書いたらこう
             case .todos(.element(id: _, action: BindableAction.binding(\Todo.isComplete))):
             Todo

             */

                /*
                 外部から影響を受ける処理(副作用)はEffect.runで管理する
                 */
                return Effect.run { send in
                    /*
                     1秒後にAction.sortCompletedTodosを送る
                     clockを使うとTest時に実際に1秒待つ必要がない
                     */
                    try await self.clock.sleep(for: .seconds(1))
                    await send(.sortCompletedTodos, animation: .default)
                }
                .cancellable(id: CancelID.todoCompletion, cancelInFlight: true)

            case .todos:
                return .none
            }
        }
        .forEach(\.todos, action: \.todos) {
            Todo()
        }
    }
}

struct AppView: View {
    @Bindable var store: StoreOf<Todos>

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Picker("Filter", selection: $store.filter.animation()) {
                    ForEach(Filter.allCases, id: \.self) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                List {
                    /*
                     store.scopeで分割した子のstoreを作り出す
                     stateとactionで子のstoreのパラメータを指定する
                     */
                    ForEach(store.scope(state: \.filteredTodos, action: \.todos)) { store in
                        TodoView(store: store)
                    }
                    .onDelete { store.send(.delete($0)) }
                    .onMove { store.send(.move($0, $1)) }
                }
            }
            .navigationTitle("Todos")
            .navigationBarItems(
                trailing: HStack(spacing: 20) {
                    EditButton()
                    Button("Clear Completed") {
                        store.send(.clearCompletedButtonTapped, animation: .default)
                    }
                    .disabled(!store.todos.contains(where: \.isComplete))
                    Button("Add Todo") { store.send(.addTodoButtonTapped, animation: .default)
                    }
                }
            )
            .environment(\.editMode, $store.editMode)
        }
    }
}

extension IdentifiedArrayOf<Todo.State> {
    static let mock: Self = [
        Todo.State(
            text: "Check Mail",
            id: UUID(),
            isComplete: false
        ),
        Todo.State(
            text: "Buy Milk",
            id: UUID(),
            isComplete: false
        ),
        Todo.State(
            text: "Call Mom",
            id: UUID(),
            isComplete: true
        ),
    ]
}

#Preview {
    AppView(
        store: Store(initialState: Todos.State(todos: .mock)) {
            Todos()
        }
    )
}

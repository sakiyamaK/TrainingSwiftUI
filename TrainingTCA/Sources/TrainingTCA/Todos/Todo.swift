//
//  Todo.swift
//  TrainingTCA
//
//  Created by sakiyamaK on 2025/10/05.
//

import ComposableArchitecture
import SwiftUI
import Observation
import SwiftData

@Reducer
struct Todo {

    /*
     ObservableState属性を付けると
     View側でstore.textなどプロパティにアクセスできるようになる
     */
    @ObservableState
    struct State: Equatable, Identifiable {
        var text: String = ""
        let id: UUID
        var isComplete = false
    }

    /*
     BindableActionに準拠させると
     View側で
     store.isComplete.toggle()
     とか
     $store.textとなって
     Viewと連動させることができる

     つまり標準の@State的なことになる
     */
    enum Action: BindableAction, Sendable {
        case toggle
        case binding(BindingAction<State>)
    }


    // ReducerOf<Self> = Reducer<Self.State, Self.Action>
    var body: some ReducerOf<Self> {
        BindingReducer()
        /*
         直接View側でstore.isComplete.toggle()ができるので
         実はこれより下はなくても動く
         */
        Reduce { state, action in
            switch action {
            case .toggle:
                state.isComplete.toggle()
                return .none
            case .binding:
                return .none
            }
        }
    }
}

struct TodoView: View {
    // StoreOf<Reducer> = Store<Reducer.State, Reducer.Action>
    @Bindable var store: StoreOf<Todo>

    var body: some View {
        HStack {
            Button {
//                store.send(.toggle)
                store.isComplete.toggle()

            } label: {
                Image(systemName: store.isComplete ? "checkmark.square" : "square")
            }
            .buttonStyle(.plain)

            TextField("Untitled Todo", text: $store.text)
        }
        .foregroundColor(store.isComplete ? .gray : nil)
    }
}

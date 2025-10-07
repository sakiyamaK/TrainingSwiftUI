// The Swift Programming Language
// https://docs.swift.org/swift-book

import ComposableArchitecture
import SwiftUI

public struct TrainingTCAView: View {
    public init() {
    }
    
    public var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink("Todos") {
                        let store = Store(initialState: Todos.State()) {
                            Todos()
                                ._printChanges()
                        }

                        TodosView(store: store)
                    }
                }
            }
            .navigationTitle("Root")
        }
        .navigationTitle("Training TCA")
    }
}

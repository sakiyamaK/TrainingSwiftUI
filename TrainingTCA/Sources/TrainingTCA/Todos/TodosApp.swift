//
//  TodosApp.swift
//  TrainingTCA
//
//  Created by sakiyamaK on 2025/10/05.
//

import ComposableArchitecture
import SwiftUI

@main
struct TodosApp: App {
  static let store = Store(initialState: Todos.State()) {
    Todos()
      ._printChanges()
  }

  var body: some Scene {
    WindowGroup {
      AppView(store: Self.store)
    }
  }
}

#Preview {
    let store = Store(initialState: Todos.State()) {
      Todos()
        ._printChanges()
    }
    AppView(store: store)
}

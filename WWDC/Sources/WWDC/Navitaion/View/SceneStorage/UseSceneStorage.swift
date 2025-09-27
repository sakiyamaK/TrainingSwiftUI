//
//  UseSceneStorage.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/24.
//

import SwiftUI

struct UseSceneStorage: View {
    @State private var navModel = NavigationModel()
    @SceneStorage("navigation") private var data: Data?

    var body: some View {
        NavigationSplitView {
            List(
                Category.allCases, selection: $navModel.selectedCategory
            ) { category in
                NavigationLink(category.localizedName, value: category)
            }
            .navigationTitle("Categories")
        } detail: {
            NavigationStack(path: $navModel.recipePaths) {
                RecipeGrid(category: navModel.selectedCategory)
            }
        }
        .task {
            if let data {
                navModel.jsonData = data
            }
        }
        .onChange(of: navModel.jsonData) { _, newValue in
            data = newValue
        }
        .environment(\.dataModel, DataModel.shared)
    }
}

#Preview {
    UseSceneStorage()
}

//
//  PushableStack.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/24.
//

import SwiftUI

struct PushableStack: View {
    @State private var path: [Recipe] = []
    @Environment(\.dataModel) private var dataModel

    var body: some View {
        NavigationStack(path: $path) {
            List(Category.allCases) { category in
                Section(category.localizedName) {
                    ForEach(dataModel.recipes(in: category)) { recipe in
                        NavigationLink(recipe.name, value: recipe)
                    }
                }
            }
            .navigationTitle("Categories")
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetail(recipe: recipe)
            }
        }
    }
}

#Preview {
    PushableStack()
        .environment(\.dataModel, DataModel.shared)
}

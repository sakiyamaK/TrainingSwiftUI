//
//  MultipleColumns.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/24.
//

import SwiftUI

struct MultipleColumns: View {
    @State private var selectedCategory: Category?
    @State private var selectedRecipe: Recipe?
    @Environment(\.dataModel) private var dataModel

    var body: some View {
        NavigationSplitView {
            List(Category.allCases, selection: $selectedCategory) { category in
                NavigationLink(category.localizedName, value: category)
            }
            .navigationTitle("Categories")
        } content: {
            List(
                dataModel.recipes(in: selectedCategory),
                selection: $selectedRecipe)
            { recipe in
                NavigationLink(recipe.name, value: recipe)
            }
            .navigationTitle(selectedCategory?.localizedName ?? "Recipes")
        } detail: {
            if let selectedRecipe {
                RecipeDetail(recipe: selectedRecipe)
            } else {
                Text("not selected")
            }
        }
    }
}

#Preview {
    MultipleColumns()
        .environment(\.dataModel, DataModel.shared)
}

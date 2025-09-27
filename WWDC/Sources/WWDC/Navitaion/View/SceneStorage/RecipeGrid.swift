//
//  RecipeGrid.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/24.
//

import SwiftUI

struct RecipeGrid: View {
    let category: Category?
    @Environment(\.dataModel) private var dataModel: DataModel

    var body: some View {
        if let category {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(dataModel.recipes(in: category)) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeTile(recipe: recipe)
                        }
                    }
                }
            }
            .navigationTitle(category.localizedName)
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetail(recipe: recipe)
            }
        } else {
            Text("Select a category")
        }
    }

    var columns: [GridItem] { [GridItem(.adaptive(minimum: 240))] }
}


#Preview {
    NavigationStack {
        RecipeGrid(category: .dessert)
    }
    .environment(\.dataModel, DataModel.shared)
}

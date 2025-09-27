//
//  RecipeDetail.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/24.
//

import SwiftUI

struct RecipeDetail: View {
    @Environment(\.dataModel) private var dataModel
    var recipe: Recipe

    var body: some View {
        Group {
            Text("Recipe details go here")
            ForEach(recipe.related.compactMap { dataModel[$0] }) { related in
                NavigationLink(related.name, value: related)
            }
        }
        .navigationTitle(recipe.name)
    }
}

#Preview {
    RecipeDetail(recipe: builtInRecipes.first!)
        .environment(\.dataModel, DataModel.shared)
}

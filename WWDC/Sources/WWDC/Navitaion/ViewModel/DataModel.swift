//
//  DataModel.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/24.
//

import SwiftUI
import Observation

@MainActor
final class DataModel {
    private var recipes: [Recipe]

    static var shared: DataModel {
        DataModel()
    }

    private init() {
        self.recipes = builtInRecipes
    }

    func recipes(in category: Category?) -> [Recipe] {
        recipes
            .filter { $0.category == category }
            .sorted { $0.name < $1.name }
    }

    subscript(recipeId: Recipe.ID) -> Recipe? {
        recipes.first { recipe in
            recipe.id == recipeId
        }
    }
}

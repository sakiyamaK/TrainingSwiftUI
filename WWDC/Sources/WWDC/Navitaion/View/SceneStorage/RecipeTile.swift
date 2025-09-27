//
//  RecipeTile.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/24.
//

import SwiftUI

struct RecipeTile: View {
    var recipe: Recipe

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.secondary.gradient)
                .frame(width: 240, height: 240)
            Text(recipe.name)
                .lineLimit(2, reservesSpace: true)
                .font(.headline)
        }
        .tint(.primary)
    }
}

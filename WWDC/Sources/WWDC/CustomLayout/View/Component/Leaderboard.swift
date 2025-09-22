//
//  CustomLayout.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/21.
//

import SwiftUI

struct Leaderboard: View {

    @Binding var pets: [Pet]
    private var totalVotes: Int { pets.compactMap(\.votes).reduce(0, +) }

    var body: some View {
        Grid(alignment: .leading) {
            ForEach(pets) { pet in
                GridRow {
                    Text(pet.type)
                    ProgressView(value: Double(pet.votes) / Double(totalVotes))
                    Text(pet.votes.description)
                        .gridColumnAlignment(.trailing)
                }
            }
        }
    }
}

#Preview {
    Leaderboard(pets: .constant(Pet.exampleData))
        .padding()
}

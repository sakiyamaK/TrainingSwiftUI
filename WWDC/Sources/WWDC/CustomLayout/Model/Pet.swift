//
//  Pet.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/21.
//

import SwiftUI
import SwiftData

@Model
final class Pet {
    var id: String { type }
    var type: String
    var votes: Int = 0

    init(type: String, votes: Int) {
        self.type = type
        self.votes = votes
    }

    @MainActor
    static let exampleData: [Pet] = [
        Pet(type: "Cat", votes: 25),
        Pet(type: "Goldfish", votes: 9),
        Pet(type: "Dog", votes: 16)
    ]
}

extension Pet {
    func rankedColor(allPets: [Pet], allRankColors: [Color] = [.yellow, .gray, .orange]) -> Color {

        let sortedPets = allPets.sorted { $0.votes > $1.votes }

        guard let rank = sortedPets.firstIndex(where: { $0.id == self.id }) else {
            return .clear
        }

        return if rank < allRankColors.count {
            allRankColors[rank]
        } else {
            .secondary
        }
    }
}

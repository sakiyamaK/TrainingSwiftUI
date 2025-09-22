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

    private var colorData: Data

    // Color型は@Modelに適応できない
    // @Transientで「これは適応できる型に変換してますよ」と明示する
    @Transient
    var color: Color {
        get {
            guard let color = try? JSONDecoder().decode(Color.self, from: colorData) else {
                return .clear
            }
            return color
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            self.colorData = data
        }
    }

    init(type: String, votes: Int, color: Color) {
        self.type = type
        self.votes = votes
        self.colorData = .init()
        self.color = color
    }

    @MainActor
    static let exampleData: [Pet] = [
        Pet(type: "Cat", votes: 25, color: .yellow),
        Pet(type: "Goldfish", votes: 9, color: .gray),
        Pet(type: "Dog", votes: 16, color: .orange)
    ]
}

extension Pet {
//    func rankedColor(allPets: [Pet], allRankColors: [Color] = [.yellow, .gray, .orange]) -> Color {
//
//        let sortedPets = allPets.sorted { $0.votes > $1.votes }
//
//        guard let rank = sortedPets.firstIndex(where: { $0.id == self.id }) else {
//            return .clear
//        }
//
//        return if rank < allRankColors.count {
//            allRankColors[rank]
//        } else {
//            .secondary
//        }
//    }

    func rank(allPets: [Pet]) -> Int {
        allPets.sorted { $0.votes > $1.votes }.firstIndex(of: self).map(\.self) ?? 0
    }
}

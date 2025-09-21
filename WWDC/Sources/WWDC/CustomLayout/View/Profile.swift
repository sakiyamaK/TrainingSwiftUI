//
//  Profile.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/21.
//

import SwiftUI

struct Profile: View {

    @Binding var pets: [Pet]

    private var isThreeWayTie: Bool {
        Set(pets.map(\.votes)).count == 1
    }

    var body: some View {
        let layout = isThreeWayTie ? AnyLayout(HStackLayout()) : AnyLayout(MyRadialLayout())
        Podium()
            .overlay(alignment: .top) {
                layout {
                    ForEach($pets) { pet in
                        Avatar(
                            pet: pet,
                            rankedColor: Binding(get: {
                                pet.wrappedValue.rankedColor(allPets: pets)
                            }, set: { _ in })
                        )
                        .rank(pet.wrappedValue.votes)
                    }
                }
                .animation(.easeIn, value: pets)
            }
    }
}


#Preview {
    Profile(pets: .constant(Pet.exampleData))
}


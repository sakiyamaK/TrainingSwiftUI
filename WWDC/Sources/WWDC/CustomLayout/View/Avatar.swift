//
//  Avatar.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/21.
//

import SwiftUI

struct Avatar: View {
    @Binding var pet: Pet
    @Binding var rankedColor: Color

    var body: some View {
        Circle()
            .frame(width: 80, height: 80)
            .foregroundColor(rankedColor)
            .shadow(radius: 3)
            .overlay {
                Text(pet.type.prefix(1).capitalized)
                    .font(.system(size: 64))
            }
    }
}

#Preview {
    let pet = Pet.exampleData.first!
    Avatar(
        pet: .constant(
            pet
        ),
        rankedColor: .constant(
            pet.rankedColor(allPets: Pet.exampleData)
        )
    )
}

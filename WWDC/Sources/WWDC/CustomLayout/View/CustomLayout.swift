//
//  CustomLayoutApp.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/21.
//

import SwiftUI

struct CustomLayout: View {

    @Binding var pets: [Pet]

    var body: some View {
        VStack(spacing: 16) {
            Profile(pets: $pets)            
            Leaderboard(pets: $pets)
                .padding(.bottom)
            StackedButtons(pets: $pets)
                .padding(.bottom)
        }
        .padding()
    }
}

#Preview {
    CustomLayout(pets: .constant(Pet.exampleData))
}

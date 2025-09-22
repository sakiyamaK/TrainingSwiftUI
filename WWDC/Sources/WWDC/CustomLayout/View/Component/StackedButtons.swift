//
//  StackedButton.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/21.
//

import SwiftUI

struct StackedButtons: View {
    @Binding var pets: [Pet]

    var body: some View {
        /*
         複数のViewから、スペースに収まる最適なViewを自動的に上から順に操作して1つだけ選ぶ
         どれも合わなければ最後のViewが選ばれる
         */
        ViewThatFits {
            MyEqualWidthHStack {
                Buttons(pets: $pets)
            }
            MyEqualWidthVStack {
                Buttons(pets: $pets)
            }
        }
    }

    private func Buttons(pets: Binding<[Pet]>) -> some View {
        ForEach($pets) { $pet in
            Button {
                withAnimation {
                    pet.votes += 1
                }
            } label: {
                Text(pet.type)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
    }
}


#Preview {
    StackedButtons(pets: .constant(Pet.exampleData))
        .environment(\.dynamicTypeSize, .accessibility3)
        .border(Color.black)
}

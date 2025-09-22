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
                    ForEach($pets) { $pet in
                        Avatar(
                            pet: $pet
                        )
                        .rank(pet.rank(allPets: pets))
                    }
                }
            }
    }
}


#Preview {
    struct PreviewHost: View {
        // ① @Stateで変更可能なpetsデータを作成
        @State private var pets = Pet.exampleData

        var body: some View {
            VStack {
                // ② $petsで@StateからBindingを渡す
                Profile(pets: $pets)

                // ③ 状態を変更するための操作ボタン
                HStack(spacing: 12) {
                    Button("Add Vote to Cat") {
                        // votesを変更して順位変動をテスト
                        if let index = pets.firstIndex(where: { $0.type == "Cat" }) {
                            pets[index].votes += 5
                        }
                    }

                    Button("Add Vote to Dog") {
                        // votesを変更して順位変動をテスト
                        if let index = pets.firstIndex(where: { $0.type == "Dog" }) {
                            withAnimation {
                                pets[index].votes += 5
                            }
                        }
                    }


                    Button("Three-Way Tie") {
                        // isThreeWayTieをtrueにしてレイアウト変更をテスト
                        for i in pets.indices {
                            pets[i].votes = 20
                        }
                    }

                    Button("Reset") {
                        // データを初期状態に戻す
                        pets = Pet.exampleData
                    }
                }
                .padding()
                .buttonStyle(.bordered)
            }
        }
    }
    return PreviewHost()
}


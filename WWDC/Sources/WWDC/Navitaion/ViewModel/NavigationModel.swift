//
//  NavigationModel.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/24.
//

import Foundation
import Observation

@Observable
@MainActor
final class NavigationModel {
    var selectedCategory: Category?
    var recipePaths: [Recipe] = []

    // 1. 保存・復元したいデータだけを持つ、Codableなstructを定義
    private struct NavigationState: Codable {
        var selectedCategory: Category?
        var recipePathIds: [Recipe.ID]
    }

    // 2. jsonDataの実装を完成させる
    var jsonData: Data? {
        get {
            // 現在のプロパティからNavigationStateのインスタンスを作成
            let state = NavigationState(
                selectedCategory: self.selectedCategory,
                recipePathIds: self.recipePaths.compactMap(\.id)
            )
            return try? JSONEncoder().encode(state)
        }
        set {
            // newValue(Data)をNavigationState.selfとしてデコード
            guard let newValue,
                  let state = try? JSONDecoder().decode(NavigationState.self, from: newValue)
            else { return }

            // デコードしたstructからプロパティを復元する
            self.selectedCategory = state.selectedCategory
            self.recipePaths = state.recipePathIds.compactMap { DataModel.shared[$0] }
        }
    }
}

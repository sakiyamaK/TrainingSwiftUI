//
//  Rank.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/21.
//
import SwiftUI

nonisolated
struct Rank: LayoutValueKey {
    static let defaultValue: Int = 1
}

extension View {
    func rank(_ value: Int) -> some View {
        layoutValue(key: Rank.self, value: value)
    }
}

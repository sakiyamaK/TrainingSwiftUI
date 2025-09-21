//
//  Podium.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/21.
//

import SwiftUI

struct Podium: View {
    var body: some View {
        VStack(spacing: 2) {
            ForEach(1..<4) { band($0) }
        }
        .aspectRatio(1.5, contentMode: .fit)
    }

    private func band(_ rank: Int) -> some View {
        Color.primary.opacity(0.1 * Double(rank))
            .overlay(alignment: .leading) { rankText(rank) }
            .overlay(alignment: .trailing) { rankText(rank) }
    }

    private func rankText(_ rank: Int) -> some View {
        Text("\(rank)")
            .font(.system(size: 64))
            .opacity(0.1)
    }
}

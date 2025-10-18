//
//  BorderedButtonStyle.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/10/19.
//

import SwiftUI

struct BorderedButtonStyle: ButtonStyle {

    // @EnvironmentプロパティラッパーでisEnabledの状態を取得
    @Environment(\.isEnabled) private var isEnabled: Bool

    var foregroundColor: Color
    var strokeColor: Color
    var fillColor: Color
    var disableForegroudColor: Color
    var disableColor: Color
    var lineWidth: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
            .foregroundColor(isEnabled ? foregroundColor : disableForegroudColor)
            .background {
                if isEnabled {
                    Capsule()
                        .fill(fillColor)
                        .stroke(strokeColor, lineWidth: lineWidth)
                } else {
                    Capsule()
                        .fill(disableColor)
                }
            }
            .opacity(configuration.isPressed ? 0.7 : 1.0)

    }
}

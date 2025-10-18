//
//  FollowButtonStyle.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/10/19.
//

import SwiftUI

struct FollowButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled: Bool

    var followedColor: Color
    var unFollowColor: Color
    var borderColor: Color
    var disableColor: Color
    var isFollowed: Bool
    var lineWidth: CGFloat


    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
            .background {
                if isFollowed {
                    Capsule()
                        .fill(followedColor)
                } else {
                    Capsule()
                        .fill(unFollowColor)
                        .stroke(borderColor, lineWidth: lineWidth)
                }
            }
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Button("ほげ") {
    }
    .buttonStyle(FollowButtonStyle(
        followedColor: .secondary,
        unFollowColor: .clear,
        borderColor: .secondary,
        disableColor: .clear,
        isFollowed: true,
        lineWidth: 1
    ))
    .foregroundStyle(.white)
}

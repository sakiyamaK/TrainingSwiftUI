//
//  ArtistCardView.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/09/17.
//

import SwiftUI

struct ArtistCardView: View {
    @Binding var artist: Artist

    var onTapRegister: () -> Void = { }

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {

                ZStack(alignment: .bottomTrailing) {
                    let size = (width: 120.0, height: 120.0)
                    AsyncImage(
                        url: artist.imageURL
                    ) { response in
                        if let image = response.image {
                            image.resizable()
                                .frame(width: size.width, height: size.height)

                        } else {
                            Color.gray
                                .frame(width: size.width, height: size.height)
                        }
                    }
                    .clipShape(Circle())

                    Circle().fill(Color.black)
                        .frame(width: size.width/4)
                }

                Text(artist.name)
            }

            Button(artist.isFollowed ? "フォロー中" :"フォロー") {
                onTapRegister()
            }
            .buttonStyle(BorderedButtonStyle(color: .secondary, lineWidth: 1))
            .foregroundStyle(.primary)
            .disabled(false)

            HStack(spacing: 0) {
                ForEach(artist.works.prefix(3)) { work in
                    AsyncImage(url: work.imageURL) { resource in
                        resource.image?
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipped()
                    }
                }

                // 2. 表示した作品数が3に満たない場合、その差分だけプレースホルダーを表示する
                let remainingCount = 3 - artist.works.count
                if remainingCount > 0 {
                    ForEach(0..<remainingCount, id: \.self) { _ in
                        DashedPlaceholderView()
                            .frame(width: 40, height: 40)
                    }
                }
            }
        }
        .padding(16)
        .background(.white)
    }
}

struct BorderedButtonStyle: ButtonStyle {

    // @EnvironmentプロパティラッパーでisEnabledの状態を取得
    @Environment(\.isEnabled) private var isEnabled: Bool

    var color: Color
    var lineWidth: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
            .foregroundColor(isEnabled ? nil : .gray)
            .overlay {
                if isEnabled {
                    Capsule()
                        .stroke(color, lineWidth: lineWidth)
                } else {
                    Capsule()
                        .fill(color)
                }
            }
            .opacity(configuration.isPressed ? 0.7 : 1.0)

    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ArtistCardView(
        artist: .constant(Artist.sample.first!)
    )
}

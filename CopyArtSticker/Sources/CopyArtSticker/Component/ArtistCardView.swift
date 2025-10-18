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

                ArtistIconImage(
                    artist: $artist,
                    size: .init(
                        width: 120,
                        height: 120
                    )
                )

                Text(artist.name)
            }

            Button(artist.isFollowed ? "フォロー中" :"フォロー") {
                onTapRegister()
            }
            .buttonStyle(
                BorderedButtonStyle(
                    foregroundColor: true ? Color.white : .primary,
                    strokeColor: .secondary,
                    fillColor: true ? .secondary : .clear,
                    disableForegroudColor: .white,
                    disableColor: .gray,
                    lineWidth: 1
                )
            )

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

#Preview(traits: .sizeThatFitsLayout) {
    ArtistCardView(
        artist: .constant(Artist.sample.first!)
    )
}

//
//  ArtistRowView.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/10/19.
//
import SwiftUI

struct ArtistRowView: View {

    @Binding var artist: Artist

    var onTapRegister: () -> Void = { }

    var body: some View {
        HStack(spacing: 24) {

            ArtistIconImage(
                artist: $artist,
                size: .init(
                    width: 120,
                    height: 120
                )
            )

            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text(artist.name).font(Font.default)
                        Text(artist.name).font(Font.footnote).foregroundStyle(Color.secondary)
                    }
                    Spacer()
                    Button(artist.isFollowed ? "フォロー中" :"フォロー") {
                        onTapRegister()
                    }
                    .buttonStyle(
                        BorderedButtonStyle(
                            foregroundColor: artist.isFollowed ? Color.white : .primary,
                            strokeColor: .secondary,
                            fillColor: artist.isFollowed ? .secondary : .clear,
                            disableForegroudColor: Color.black,
                            disableColor: .gray,
                            lineWidth: 1
                        )
                    )
                }

                HStack(spacing: 2) {
                    ForEach(artist.works) { work in
                        AsyncImage(url: work.imageURL){ response in
                            if let image = response.image {
                                image.resizable()
                                    .frame(width: 30, height: 30)

                            } else {
                                Color.gray
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                }
            }
        }
        .frame(height: 120)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ArtistRowView(artist: .constant(Artist.sample.first!))
}

//
//  ArtistIconImage.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/10/19.
//

import SwiftUI

struct ArtistIconImage: View {

    @Binding var artist: Artist
    let size: CGSize

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
    }
}

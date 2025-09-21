//
//  WorkCardView.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/09/17.
//

import SwiftUI

struct WorkCardView: View {

    let work: Work
    var onToggleBookmark: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: work.imageURL) { phase in
                    switch phase {
                    case .empty:
                        Color.gray.opacity(0.1)
                            .overlay(ProgressView())
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Color.gray.opacity(0.2)
                            .overlay(Image(systemName: "photo").font(.largeTitle))
                    @unknown default:
                        Color.gray.opacity(0.1)
                    }
                }
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                if let badge = work.badgeText, !badge.isEmpty {
                    HStack(spacing: 6) {
                        Image(systemName: "seal.fill")
                            .foregroundStyle(.white)
                        Text(badge)
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.semibold))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.black.opacity(0.75), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .padding(10)
                }

                // 右下のブックマークボタン
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { onToggleBookmark?() }) {
                            Image(systemName: work.isBookmarked ? "bookmark.fill" : "bookmark")
                                .foregroundStyle(work.isBookmarked ? .teal : .secondary)
                                .padding(10)
                                .background(.ultraThinMaterial, in: Circle())
                        }
                    }
                    Spacer().frame(height: 10)
                }
                .padding(6)
            }

            // テキスト部
            VStack(alignment: .leading, spacing: 4) {
                Text(work.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                Text(work.artistName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(work.price)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.primary)

                if let eventTitle = work.eventTitle {
                    Text(eventTitle)
                        .font(.subheadline)
                        .foregroundStyle(.teal)
                        .lineLimit(1)
                }
            }
            .padding(.horizontal, 2)
            .padding(.bottom, 4)
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    ScrollView {
        VStack(alignment: .leading, spacing: 16) {
            Button(action: {
                print("タップ")
            }, label: {
                WorkCardView(
                    work: Work.sample.first!,
                    onToggleBookmark: {
                        print("bookmark tapped")
                    }
                )
                .padding(.horizontal)
            })
            .buttonStyle(.plain)
        }
    }
}

//
//  HomeSearchBarView.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/09/15.
//

import SwiftUI

struct HomeSearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        HStack(spacing: 16) {

            // 検索フィールド
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("アーティスト、イベントなど", text: $searchText)
            }
            .padding(8)
            .background(Color(.systemGray5), in: Capsule())

            Group {
                // ボタン1
                Button(action: { print("ボタン1") }) {
                    Image(systemName: "location.fill")
                }

                // ボタン2
                Button(action: { print("ボタン2") }) {
                    Image(systemName: "face.smiling")
                }
            }
            .foregroundStyle(Color.black)
        }
    }
}


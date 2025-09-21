//
//  HomeNavigationView.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/09/15.
//

import SwiftUI

struct HomeNavigationView<Content: View>: View {

    @Binding var isToolbarHidden: Bool
    let content: Content

    init(isToolbarHidden: Binding<Bool> = .constant(false), @ViewBuilder content: () -> Content) {
        self.content = content()
        self._isToolbarHidden = isToolbarHidden
    }

    var body: some View {
        NavigationStack {
            VStack {
                content
            }
            .toolbar(isToolbarHidden ? .hidden : .visible)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.primary)
                        .allowsHitTesting(false)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("ベルがタップされました！")
                    }) {
                        Image(systemName: "bell.fill")
                    }
                    .foregroundColor(.primary) // アイコンの色を指定
                }
            }
        }
    }
}

#Preview {
    HomeNavigationView {
        Text("ここにコンテンツが入るよ")
    }
}

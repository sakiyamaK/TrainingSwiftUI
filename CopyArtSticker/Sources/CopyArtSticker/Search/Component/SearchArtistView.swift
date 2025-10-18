//
//  SearchArtistView.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/10/17.
//

import SwiftUI

struct SearchArtistView: View {

    enum SearchType: Int, CaseIterable, Identifiable {
        case recommend = 0, name
        var id: String { self.rawValue.description }

        var displayName: String {
            switch self {
            case .recommend: return "おすすめ"
            case .name: return "名前"
            }
        }
    }

    @Binding var artists: [Artist]
    @State private var selectedSearchType: SearchType = .recommend

    /*
     computed propertyじゃないと定義できない
     なぜなら

     var animatedSelection: Binding<SearchType> = ...
     だと、まだインスタンス生成前でselfが使えない

     lazy var animatedSelection: Binding<SearchType> = ...
     だと、Viewがstructでmutatingな変数が定義できない

     bodyの内部に
     let animatedSelection: Binding<SearchType> = ...
     だと、Stateが更新される度にbodyが走るので負荷が高い
     */
    private var animatedSelection: Binding<SearchType> { Binding<SearchType>(
        get: { self.selectedSearchType },
        set: { newValue in
            // withAnimationブロックで状態の変更を囲む
            withAnimation(.easeInOut) {
                self.selectedSearchType = newValue
            }
        })
    }

    private func configureUIKitComponent() {
        // 選択中のセグメントの背景色
        let appearance = UISegmentedControl.appearance()

        appearance.selectedSegmentTintColor = .black
        appearance.setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .selected
        )
        appearance.setTitleTextAttributes(
            [.foregroundColor: UIColor.secondaryLabel],
            for: .normal
        )
    }

    var body: some View {

        configureUIKitComponent()

        return VStack {
            Picker("Favorite Flavor", selection: animatedSelection) {
                // Flavor.allCasesをループして、各ケースのTextビューを生成
                ForEach(SearchType.allCases) { searchType in
                    Text(searchType.displayName)
                        .foregroundStyle(.blue)
                        .tag(searchType)
                }
            }
            .pickerStyle(.segmented)
            .fixedSize()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()

            TabView(selection: $selectedSearchType) {
                // 1ページ目のビュー
                List($artists) { artist in
                    ArtistRowView(artist: artist)
                }
                .listStyle(.plain)
                .tag(SearchType.recommend)

                // 2ページ目のビュー
                List($artists) { artist in
                    ArtistRowView(artist: artist)
                }
                .listStyle(.plain)
                .tag(SearchType.name)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

#Preview {
    SearchArtistView(artists: .constant(Artist.sample))
}

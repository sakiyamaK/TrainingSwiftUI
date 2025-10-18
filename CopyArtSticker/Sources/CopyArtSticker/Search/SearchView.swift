//
//  SearchView.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/10/12.
//

import SwiftUI

enum SearchTabType: Int, TabType {
    case work, artist, event, reading, space, user

    var title: String {
        switch self {
        case .work: return "作品"
        case .artist: return "アーティスト"
        case .event: return "イベント"
        case .reading: return "読書"
        case .space: return "スペース"
        case .user: return "ユーザー"
        }
    }

    var id: Int {
        rawValue
    }
}

struct SearchView: View {

    @State private var selectedTab: SearchTabType = .work
    @State private var searchText: String = ""

    fileprivate func MainView() -> VStack<TupleView<(some View, TopTabBarView<SearchTabType>, some View)>> {
        return VStack(spacing: 0) {
            
            SearchBarView(searchText: $searchText)
                .padding()
            
            TopTabBarView(
                tabs: SearchTabType.allCases,
                selectedTab: $selectedTab,
                isAnimation: true
            )
            
            TabView(selection: $selectedTab) {
                ForEach(SearchTabType.allCases) { tab in
                    switch tab {
                    case .work:
                        SearchWorkView(works: .constant(Work.sample))
                            .tag(tab)
                    case .artist:
                        SearchArtistView(artists: .constant(Artist.sample))
                            .tag(tab)
                    default:
                        Text("\(selectedTab.id) コンテンツ")
                            .onAppear {
                                print(tab.id)
                            }
                            .tag(tab)
                    }
                }
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            MainView()

            Button {
                print("tap")
            } label: {
                HStack {
                    Image(systemName: "house")
                    Text("条件から探す")
                }
                .padding()
                .background(.white)
                .foregroundColor(.black)
                .clipShape(Capsule())
                .shadow(radius: 4, x: 0, y: 4)
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}

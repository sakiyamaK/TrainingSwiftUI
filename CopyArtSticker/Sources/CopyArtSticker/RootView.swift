//
//  RootView.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/10/12.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView(events: .constant(Event.sample), artists: .constant(Artist.sample))
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    RootView()
}

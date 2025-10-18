//
//  TopTabBarView.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/10/19.
//

import SwiftUI

protocol TabType: CaseIterable, Identifiable, Equatable {
    var title: String { get }
}

struct TopTabBarView<Tab: TabType>: View where
Tab.AllCases: RandomAccessCollection, Tab.ID: BinaryInteger, Tab.ID: Hashable {

    let tabs: [Tab]
    @Binding var selectedTab: Tab
    let isAnimation: Bool

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(Tab.allCases) { tab in
                    ZStack(alignment: .bottom) {
                        Button {
                            if isAnimation {
                                withAnimation {
                                    selectedTab = tab
                                }
                            } else {
                                selectedTab = tab
                            }
                        } label: {
                            Text(tab.title)
                                .bold()
                                .foregroundStyle(
                                    selectedTab == tab ? .black : .gray
                                )
                        }
                        .id(tab.id)
                        .padding()

                        if selectedTab == tab {
                            Color.primary.frame(height: 1)
                        } else {
                            Color.secondary.frame(height: 1)
                        }
                    }
                }
            }
        }
    }
}

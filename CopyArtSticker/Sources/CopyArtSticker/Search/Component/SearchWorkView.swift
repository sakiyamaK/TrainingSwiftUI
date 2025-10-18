//
//  SearchWorkView.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/10/12.
//

import SwiftUI

struct SearchWorkView: View {

    @Binding var works: [Work]

    var body: some View {
        ScrollView {
            HStack {
                Button {
                    print("tap")
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("販売中の作品")
                    }
                }
                Spacer()

                Button {
                    print("tap")
                } label: {
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                        Text("おすすめ順")
                    }
                }
            }
            .padding()

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], content: {
                ForEach(works) { work in
                    WorkCardView(work: work)
                }
            })
            .padding(.horizontal)

        }
    }
}

#Preview {
    SearchWorkView(works: .constant(Work.sample))
}

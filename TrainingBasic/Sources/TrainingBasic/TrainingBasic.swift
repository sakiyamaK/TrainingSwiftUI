// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct TrainingBasicView: View {

    @State private var currentPage = 0

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<5) { index in
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: "https://picsum.photos/300/300")){ image in
                            image
                                .resizable()
                                .aspectRatio(16/9, contentMode: .fit)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .aspectRatio(16/9, contentMode: .fit)
                        }
                        .background(Color.gray)

                        Text("タイトルでーす")
                    }
                    .background(Color.blue)
                    .frame(maxWidth: .infinity)
                    .tag(index)
                }
            }
//            .tabViewStyle(.page(indexDisplayMode: .never))
            .tabViewStyle(.page)

            Spacer()
        }
    }
}


#Preview {
    TrainingBasicView()
}


//        VStack {
//            VStack(alignment: .leading, spacing: 8) {
//                Image(systemName: "square.and.arrow.up")
//                    .resizable()
//                    .aspectRatio(16/9, contentMode: .fill)
//                    .background(Color.gray.opacity(0.1))
//
//                Text("event.title")
//                    .font(.headline)
//                    .padding(.horizontal)
//            }
//            TabView(selection: $currentPage) {
//                VStack(alignment: .leading, spacing: 8) {
//                    Image(systemName: "square.and.arrow.up")
//                        .resizable()
//                        .aspectRatio(16/9, contentMode: .fill)
//                        .background(Color.gray.opacity(0.1))
//
//                    Text("event.title")
//                        .font(.headline)
//                        .padding(.horizontal)
//                }
//                .tag(0)
//                ForEach(0..<3) { index in
//                    VStack(alignment: .leading, spacing: 8) {
//                        Image(systemName: "square.and.arrow.up")
//                            .resizable()
//                            .aspectRatio(16/9, contentMode: .fill)
//                            .background(Color.gray.opacity(0.1))
//
//                        Text("event.title")
//                            .font(.headline)
//                            .padding(.horizontal)
//                    }
//                    .tag(index)
//                }
//            }
//            .tabViewStyle(.page(indexDisplayMode: .never))
//            .background(Color.purple)
//            Spacer()
//        }

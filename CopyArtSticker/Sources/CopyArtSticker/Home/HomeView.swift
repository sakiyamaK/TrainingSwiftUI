import SwiftUI

struct HomeView: View {

    @Binding var events: [Event]
    @Binding var artists: [Artist]
    @State private var isToolbarHidden: Bool = false
    @State private var searchText: String = ""

    fileprivate func SectionHeader(title: String, tap: @escaping () -> Void) -> some View {
        HStack {
            Text(title)
            Spacer()
            Button("→") {
                tap()
            }
            .buttonStyle(.plain)
        }
        .font(.title2.bold())
        .padding(.horizontal)
    }
    
    fileprivate func ToolbarHiddenCheckView() -> some View {
        GeometryReader { geometry in
            Color.clear
                .onChange(of: geometry.frame(in: .named("scroll")).minY, { oldValue, newValue in
                    let isToolbarHidden = newValue < -100
                    if isToolbarHidden != self.isToolbarHidden {
                        Task { @MainActor in
                            withAnimation {
                                self.isToolbarHidden = isToolbarHidden
                            }
                        }
                    }
                })
        }
        .frame(height: 0)
    }
    
    fileprivate func NewArtistSectionHeader(tap: @escaping () -> Void) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("ウェイティングリスト登録受付中")
                .font(.title3.bold())
            
            Text("今は作品を購入できないアーティストの新作も、順番にご案内します。")
                .font(.subheadline)

            Button("詳細はこちら") {
                tap()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundStyle(.link)
//            Text("詳細はこちら")
//                .frame(maxWidth: .infinity, alignment: .trailing)
//                .foregroundStyle(.link)
        }
    }
    
    var body: some View {
        HomeNavigationView(isToolbarHidden: $isToolbarHidden) {
            VStack(spacing: 0) {
                HomeSearchbarView(searchText: $searchText)
                    .padding()

                ScrollView(.vertical, showsIndicators: false) {

                    ToolbarHiddenCheckView()

                    LazyVStack(alignment: .leading, spacing: 24) {

                        HeaderCarouselView(events: $events)

                        Group {
                            SectionHeader(title: "注目のアートイベント", tap: {
                                print("やじるじタップ！")
                            })

                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach($events) { event in
                                        Button {
                                            print(event.title)
                                        } label: {
                                            EventCardView(event: event)
                                        }
                                        .foregroundStyle(.primary)
                                    }
                                }
                                .padding()
                            }
                        }

                        Group {
                            SectionHeader(title: "あなたにおすすめの作品", tap: {
                                print("やじるじタップ！")
                            })

                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach($events) { $event in
                                        Button {
                                            print(event.title)
                                        } label: {
                                            WorkCardView(
                                                work: .init(
                                                    title: "Life is Beautiful",
                                                    artistName: "須田 日菜子",
                                                    price: "¥88,000",
                                                    eventTitle: "須田日菜子「からだと構図」",
                                                    badgeText: "限定販売",
                                                    imageURLStr: "https://picsum.photos/600/400",
                                                    isBookmarked: false
                                                ),
                                                onToggleBookmark: {}
                                            )
                                        }
                                        .foregroundStyle(.primary)
                                    }
                                }
                                .padding()
                            }
                        }

                        Group {
                            VStack(alignment: .leading, spacing: 8) {

                                NewArtistSectionHeader(tap: {
                                    print("tap")
                                })
                                .padding()

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach($artists) { artist in
                                            ArtistCardView(artist: artist)
                                        }
                                    }
                                    .padding(.horizontal)
                                }

                                Spacer()
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .background(Color.secondary.opacity(0.1))


                        Group {
                            Color.clear
                        }
                        .frame(height: 500)
                    }
                }
                .coordinateSpace(name: "scroll")
            }
        }
    }
}

#Preview {
    HomeView(events: .constant(Event.sample), artists: .constant(Artist.sample))
}

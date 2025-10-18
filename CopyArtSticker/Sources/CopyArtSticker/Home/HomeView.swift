import SwiftUI

struct Hoge {

    var text = "Hello, World!"
    var number: Int = 1
    var isOn: Bool = false

    var number2: Int {
        return number * 1
    }
}

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
        }
    }

    fileprivate func MainView() -> some View {
        return HomeNavigationView(isToolbarHidden: $isToolbarHidden) {
            VStack(spacing: 0) {

                HomeSearchBarView(searchText: $searchText)
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
                            SectionHeader(title: "カテゴリーから探す") {

                            }

                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], content: {
                                ForEach(0..<20) { index in
                                    Button {
                                        print("tap")
                                    } label: {
                                        // 各グリッドアイテムの見た目を定義します。
                                        ZStack(alignment: .bottomLeading) {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.orange)
                                                .frame(height: 150) // アイテムの高さを固定

                                            Text("Item \(index)")
                                                .foregroundColor(.white)
                                                .font(.headline)
                                                .padding(10)
                                        }
                                    }
                                }
                            })
                            .padding(.horizontal)
                        }
                        
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
    HomeView(
        events: .constant(Event.sample),
        artists: .constant(Artist.sample)
    )
}



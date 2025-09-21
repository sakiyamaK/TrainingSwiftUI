//
//  HeaderCarouselView.swift
//  TrainingBasic
//
//  Created by sakiyamaK on 2025/09/15.
//

import SwiftUI
import SwiftData

// ダミー要素にユニークなIDを持たせるためのラッパー構造体
struct IdentifiableEvent: Identifiable, Equatable {
    let id = UUID()
    var event: Event

    static func == (lhs: IdentifiableEvent, rhs: IdentifiableEvent) -> Bool {
        lhs.id == rhs.id
    }
}
struct HeaderCarouselView: View {
    @Binding var events: [Event]
    @State private var displayEvents: [IdentifiableEvent] = []
    @State private var currentDisplayEventID: UUID?
    private var currentDisplayEvent: IdentifiableEvent? {
        if let currentDisplayEventID {
            displayEvents.first(
                where: {
                    $0.id == currentDisplayEventID
                })
        } else {
            nil
        }
    }

    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack {
                    ForEach(displayEvents) { displayEvent in
                        let event = displayEvent.event
                        VStack(alignment: .leading) {

                            AsyncImage(url: event.imageUrl) { image in
                                image
                                    .resizable()
                                    .aspectRatio(16/9, contentMode: .fit)
                            } placeholder: {
                                Color.gray
                                    .aspectRatio(16/9, contentMode: .fit)
                            }

                            Text(event.title)
                                .font(.headline)
                                .padding(.horizontal)
                        }
                        .containerRelativeFrame(.horizontal)
                        .id(displayEvent.id)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $currentDisplayEventID)

            if displayEvents.count > 2 {
                HStack(spacing: 8) {
                    ForEach(displayEvents) { displayEvent in
                        if displayEvent == displayEvents.first || displayEvent == displayEvents.last {
                        } else {
                            Circle()
                                .fill(displayEvent == currentDisplayEvent ? Color.black : Color.black.opacity(0.5))
                                .frame(width: 8, height: 8)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear(perform: setupDisplayEvents)
        .onChange(of: events, setupDisplayEvents)
        .onChange(of: currentDisplayEventID) { _, newValue in
            // スクロールが終わるたびにワープが必要か判定
            handleLooping(newValue: newValue)
        }
        .onReceive(timer) { _ in
            // タイマーで自動スクロール
            handleTimerScroll()
        }
    }
}

private extension HeaderCarouselView {
    private func setupDisplayEvents() {
        guard events.count > 1, let first = events.first, let last = events.last else { return }
        displayEvents = ([last] + events + [first]).map { IdentifiableEvent(event: $0) }

        currentDisplayEventID = displayEvents.count > 1 ? displayEvents[1].id : nil
    }

    private func handleLooping(newValue: UUID?) {
        guard displayEvents.count > 2 else { return }

        // 最後のダミーページに来たら
        if newValue == displayEvents.last?.id {
            // アニメーションを「無効」にして、最初の本物ページにIDを書き換える
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                currentDisplayEventID = displayEvents[1].id
            }
        }

        // 最初のダミーページに来たら
        if newValue == displayEvents.first?.id {
            // アニメーションを「無効」にして、最後の本物ページにIDを書き換える
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                currentDisplayEventID = displayEvents[displayEvents.count - 2].id
            }
        }
    }

    private func handleTimerScroll() {
        guard let currentDisplayEventID,
              let currentIndex = displayEvents.firstIndex(where: { $0.id == currentDisplayEventID })
        else { return }

        let nextIndex = currentIndex + 1

        if nextIndex < displayEvents.count {
            // アニメーションを「有効」にして、次のページにIDを書き換える
            withAnimation(.easeInOut(duration: 0.4)) {
                self.currentDisplayEventID = displayEvents[nextIndex].id
            }
        }
    }
}


#Preview(traits: .fixedLayout(width: 300, height: 200)) {
    HeaderCarouselView(events: .constant(Event.sample))
}

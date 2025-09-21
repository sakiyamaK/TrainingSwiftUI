//
//  Event.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/09/15.
//

import Foundation
import SwiftData

@Model
final class Event {
    var title: String
    var imageName: String
    var imageUrl: URL? {
        URL(string: imageName)
    }
    var startDate: Date
    var endDate: Date

    init(title: String, imageName: String, startDate: Date, endDate: Date) {
        self.title = title
        self.imageName = imageName
        self.startDate = startDate
        self.endDate = endDate
    }

    static var sample: [Event] {
        [
            Event(title: "Tokyo Gendai 2025", imageName: "https://picsum.photos/300/200", startDate: Date(), endDate: Date()),
            Event(title: "国際芸術祭「あいち2025」", imageName: "https://picsum.photos/300/200", startDate: Date(), endDate: Date()),
            Event(title: "蜷川実花展", imageName: "https://picsum.photos/300/200", startDate: Date(), endDate: Date())
        ]
    }
}

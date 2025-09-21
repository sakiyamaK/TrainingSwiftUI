//
//  Work.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/09/17.
//

import Foundation
import SwiftData

@Model
final class Work {
    var title: String
    var artistName: String
    var price: String          // 例: "¥88,000"（フォーマット済み）
    var eventTitle: String?   // 例: "須田日菜子「からだと構図」"
    var badgeText: String?     // 例: "限定販売"
    var imageURLStr: String?
    var imageURL: URL? {
        URL(string: imageURLStr ?? "")
    }
    var isBookmarked: Bool

    init(
        title: String,
        artistName: String,
        price: String,
        eventTitle: String? = nil,
        badgeText: String? = nil,
        imageURLStr: String? = nil,
        isBookmarked: Bool
    ) {
        self.title = title
        self.artistName = artistName
        self.price = price
        self.eventTitle = eventTitle
        self.badgeText = badgeText
        self.imageURLStr = imageURLStr
        self.isBookmarked = isBookmarked
    }

    static var sample: [Work] {
        [
            Work(
                title: "Life is Beautiful",
                artistName: "須田 日菜子",
                price: "¥88,000",
                eventTitle: "須田日菜子「からだと構図」",
                badgeText: "限定販売",
                imageURLStr: "https://picsum.photos/600/400",
                isBookmarked: false
            ),
            Work(
                title: "Life is Beautiful",
                artistName: "須田 日菜子",
                price: "¥88,000",
                eventTitle: "須田日菜子「からだと構図」",
                badgeText: "限定販売",
                imageURLStr: "https://picsum.photos/600/400",
                isBookmarked: false
            ),
            Work(
                title: "Life is Beautiful",
                artistName: "須田 日菜子",
                price: "¥88,000",
                eventTitle: "須田日菜子「からだと構図」",
                badgeText: "限定販売",
                imageURLStr: "https://picsum.photos/600/400",
                isBookmarked: false
            ),
            Work(
                title: "Life is Beautiful",
                artistName: "須田 日菜子",
                price: "¥88,000",
                eventTitle: "須田日菜子「からだと構図」",
                badgeText: "限定販売",
                imageURLStr: "https://picsum.photos/600/400",
                isBookmarked: false
            ),
        ]
    }
}

//
//  Artist.swift
//  CopyArtSticker
//
//  Created by sakiyamaK on 2025/09/17.
//

import Foundation
import SwiftData

@Model
final class Artist {
    var name: String
    var imageURLStr: String?
    var isFollowed: Bool = false
    var works: [Work] = []
    var imageURL: URL? {
        URL(string: imageURLStr ?? "")
    }

    init(name: String, imageURLStr: String? = nil, isFollowed: Bool, works: [Work] = []) {
        self.name = name
        self.imageURLStr = imageURLStr
        self.isFollowed = isFollowed
        self.works = works
    }

    static var sample: [Artist] {
        [
            Artist(name: "あいうえお", imageURLStr: "https://picsum.photos/120/120", isFollowed: false, works: Array(Work.sample[0...1])),
            Artist(name: "かきくけこ", imageURLStr: "https://picsum.photos/120/120", isFollowed: true),
            Artist(name: "さしすせそ", imageURLStr: "https://picsum.photos/120/120", isFollowed: false, works: Work.sample),
            Artist(name: "なにぬねの", imageURLStr: "https://picsum.photos/120/120", isFollowed: true),
        ]
    }

}

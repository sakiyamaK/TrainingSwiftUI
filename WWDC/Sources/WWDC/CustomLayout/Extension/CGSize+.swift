//
//  CGSize+.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/21.
//

import SwiftUI

extension CGSize {
    var proposedViewSize: ProposedViewSize {
        .init(width: self.width, height: self.height)
    }

    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

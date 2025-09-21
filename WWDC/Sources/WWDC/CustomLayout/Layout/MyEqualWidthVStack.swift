//
//  MyEqualWidthVStack.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/21.
//

import SwiftUI

struct MyEqualWidthVStack: Layout {

    /*
     各パラメータの解説はMyEqualWidthHStackに記載
     */
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) -> CGSize {
        if !subviews.isEmpty {
            let maxSize = subviews.maxSize
            return CGSize(
                width: maxSize.width,
                height: maxSize.height  * CGFloat(subviews.count) + subviews.spacings(along: .vertical).reduce(.zero, +)
            )
        } else {
            return .zero
        }
    }

    /*
     各パラメータの解説はMyEqualWidthHStackに記載
     */
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) {
        guard !subviews.isEmpty else { return }

        var y = bounds.minY + subviews.maxSize.height / 2

        for index in subviews.indices {
            subviews[index].place(
                at: CGPoint(x: bounds.midX, y: y),
                anchor: .center,
                proposal: subviews.maxSize.proposedViewSize
            )
            y += subviews.maxSize.height + subviews.spacings(along: .vertical)[index]
        }
    }
}

#Preview {
    MyEqualWidthVStack {
        Buttons(pets: .constant(Pet.exampleData))
    }
    .border(Color.black)
}

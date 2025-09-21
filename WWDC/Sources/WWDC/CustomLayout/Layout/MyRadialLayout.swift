//
//  MyRadialLayout.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/21.
//

import SwiftUI

struct MyRadialLayout: Layout {

    /*
     各パラメータの解説はMyEqualWidthHStackに記載
     */
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) -> CGSize {
        /*
         親がVStack, HStack, Listなど
         高さや幅が自身で決まらないViewの場合は
         proposalのwidthかheightがnilになる

         そういう場合、nilの部分をデフォルト値(0)に変えるのが
         replacingUnspecifiedDimensions

         replacingUnspecifiedDimensions(by: Size)
         で指定サイズを入れることもできる
         */
        proposal.replacingUnspecifiedDimensions()
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
        let radius = Swift.min(bounds.size.width, bounds.size.height) / 3.0
        let angle = Angle.degrees(360.0 / Double(subviews.count)).radians
        let ranks = subviews.map { subview in
            subview[Rank.self]
        }
        let offset = getOffset(ranks)

        for (index, subview) in subviews.enumerated() {
            var point = CGPoint(x: 0, y: -radius)
                .applying(CGAffineTransform(
                    rotationAngle: angle * Double(index) + offset))

            point.x += bounds.midX
            point.y += bounds.midY

            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

private extension MyRadialLayout {
    func getOffset(_ ranks: [Int]) -> Double {
        guard ranks.count == 3,
              !ranks.allSatisfy({ $0 == ranks.first }) else { return 0.0 }
        var fraction: Double
        if ranks[0] == 1 {
            fraction = residual(rank1: ranks[1], rank2: ranks[2])
        } else if ranks[1] == 1 {
            fraction = -1 + residual(rank1: ranks[2], rank2: ranks[0])
        } else {
            fraction = 1 + residual(rank1: ranks[0], rank2: ranks[1])
        }

        return fraction * 2.0 * Double.pi / 3.0
    }

    func residual(rank1: Int, rank2: Int) -> Double {
        if rank1 == 1 {
            return -0.5
        } else if rank2 == 1 {
            return 0.5
        } else if rank1 < rank2 {
            return -0.25
        } else if rank1 > rank2 {
            return 0.25
        } else {
            return 0
        }
    }
}

#Preview {
    MyRadialLayout {
        Buttons(pets: .constant(Pet.exampleData))
    }
    .border(Color.black)
}

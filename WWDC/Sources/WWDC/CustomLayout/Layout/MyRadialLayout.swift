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

        let offset = ranks.offset

        for (index, subview) in subviews.enumerated() {
            let affine = CGAffineTransform(
                rotationAngle: angle * Double(index) + offset)

            var point = CGPoint(x: 0, y: -radius)
                .applying(affine)

            point.x += bounds.midX
            point.y += bounds.midY

            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

private extension [Int] {
    var offset: Double {

        guard self.count == 3,
              !self.allSatisfy({ $0 == self.first }) else { return 0.0 }

        let fraction = if self[0] == 0 {
            residual(rank1: self[1], rank2: self[2])
        } else if self[1] == 0 {
            -1 + residual(rank1: self[2], rank2: self[0])
        } else {
            1 + residual(rank1: self[0], rank2: self[1])
        }

        return fraction * 2.0 * Double.pi / 3.0
    }

    func residual(rank1: Int, rank2: Int) -> Double {
        if rank1 == 0 {
            -0.5
        } else if rank2 == 0 {
            0.5
        } else if rank1 < rank2 {
            -0.25
        } else if rank1 > rank2 {
            0.25
        } else {
            0
        }
    }
}

#Preview {
    MyRadialLayout {
        Group {
            Color.red
            Color.green
            Color.blue
        }
        .frame(width: 100, height: 100)
    }
    .border(Color.black)
}

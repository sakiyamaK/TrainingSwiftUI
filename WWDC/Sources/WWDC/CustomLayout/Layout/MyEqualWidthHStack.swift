//
//  MyEqualWidthHStack.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/21.
//

import SwiftUI

struct MyEqualWidthHStack: Layout {

    /*
     子Viewたちを表示する領域を決める

     proposal: ProposedViewSize
     親Viewから子Viewに伝える表示可能領域の大きさ

     subviews: Subviews
     子Viewたちをもつ型でRandomAccessCollectionに準拠しているため、配列みたいなもの
     内部でレイアウトを決めるためのパラメータやメソッドを持つ

     cache: inout Void
     複雑な計算をキャッシュさせたいならこれを使う
     */
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) -> CGSize {
        if !subviews.isEmpty {
            let maxSize = subviews.maxSize
            return CGSize(
                width: maxSize.width * CGFloat(subviews.count) + subviews.spacings(along: .horizontal).reduce(.zero, +),
                height: maxSize.height)
        } else {
            return .zero
        }
    }

    /*
     子ViewたちをsizeThatFitsで決まった領域内のどこに表示するか決めるメソッド

     in bounds: CGRect
     sizeThatFitsで決まった領域

     proposal: ProposedViewSize
     sizeThatFitsのproposalと同じ

     subviews: Subviews
     sizeThatFitsのsubviewsと同じ

     cache: inout Void
     複雑な計算をキャッシュさせたいならこれを使う
     */

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) {
        guard !subviews.isEmpty else { return }

        /*
         suviews[0]の初期値

         minXが0とは限らない
         maxSize.width / 2だけ余白を入れたい
         */
        var x = bounds.minX + subviews.maxSize.width / 2

        for index in subviews.indices {
            /*
             subviewをどこに配置するか決めるメソッド
             at 座標を指定
             anchor atの座標にsubviewのどこを配置するのか決める、デフォで左上のtopLeading
             proposal 表示可能領域の提案サイズ
             */
            subviews[index].place(
                at: CGPoint(x: x, y: bounds.midY),
                anchor: .center,
                proposal: subviews.maxSize.proposedViewSize
            )
            x += subviews.maxSize.width + subviews.spacings(along: .horizontal)[index]
        }
    }
}

#Preview {
    MyEqualWidthHStack {
        Buttons(pets: .constant(Pet.exampleData))
    }
    .border(Color.black)
}

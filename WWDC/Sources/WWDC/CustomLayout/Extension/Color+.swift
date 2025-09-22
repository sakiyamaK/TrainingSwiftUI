//
//  Color+.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/22.
//

import SwiftUI


extension Color: @retroactive Codable {
    private struct CodableColor: Codable {
        var red: Double
        var green: Double
        var blue: Double
        var alpha: Double
    }

    public func encode(to encoder: Encoder) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        // UIColorに変換してRGBAの値を取得する
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        var container = encoder.singleValueContainer()
        try? container.encode(CodableColor(red: red, green: green, blue: blue, alpha: alpha))
    }

    public init(from decoder: Decoder) {
        guard
            let container = try? decoder.singleValueContainer(),
            let codableColor = try? container.decode(CodableColor.self) else {
            self = .clear
            return
        }
        self.init(
            red: codableColor.red,
            green: codableColor.green,
            blue: codableColor.blue,
            opacity: codableColor.alpha
        )
    }
}

private extension CGFloat { var double: Double { Double(self) } }

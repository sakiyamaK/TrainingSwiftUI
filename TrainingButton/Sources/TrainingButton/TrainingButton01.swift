//
//  TrainingButton01.swift
//  TrainingButton
//
//  Created by sakiyamaK on 2025/08/03.
//

import SwiftUI
import Util

public struct TrainingButton01View: View {
    public var body: some View {
        VStack {
            Button("テキスト") {
                Log()
            }

        }
    }
}


#Preview {
    TrainingButton01View()
}

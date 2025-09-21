//
//  EventCardView.swift
//
//  Created by sakiyamaK on 2025/09/15.
//

import SwiftUI

struct EventCardView: View {
    @Binding var event: Event

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Spacer()
                Image(systemName: event.imageName)
                    .resizable()
                    .aspectRatio(16/9, contentMode: .fit)
                    .padding()
                Spacer()
            }
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(2) // 2行までに制限

                Text("2025.09.13 - 09.16") // 日付は仮表示
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical)
        }
        .background(Color.white) // カードの背景色
        .frame(width: 280)
    }
}

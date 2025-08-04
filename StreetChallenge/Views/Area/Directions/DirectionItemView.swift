//
//  DirectionItemView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 11/06/2025.
//
import SwiftUI

struct DirectionItem {
    let text: String
    let transportType: TransportType
    let icon: String
}

struct DirectionItemView: View {
    let item: DirectionItem
    let index: Int

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Icon or step number
            ZStack {
                Circle()
                    .fill(item.transportType.color.opacity(0.1))
                    .frame(width: 32, height: 32)

                Image(systemName: item.icon)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(item.transportType.color)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(item.text)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)


                Text(item.transportType.displayName)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(item.transportType.color)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(item.transportType.color.opacity(0.1))
                    .clipShape(Capsule())

            }

            Spacer()
        }
    }
}

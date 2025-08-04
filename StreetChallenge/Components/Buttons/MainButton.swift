//
//  MainButton.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 26/11/2024.
//
import SwiftUI

struct MainButton: View {
    var title: String = ""
    var colour: Color = .white
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(colour)
                .frame(maxWidth: .infinity, minHeight: 50)
                .padding(.horizontal, 20)
                .background(
                    Color.blue,
                    in: RoundedRectangle(cornerRadius: 16)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.blue.opacity(0.2), lineWidth: 0.5)
                )
        }
        .buttonStyle(AppleButtonStyle())
        .padding(.horizontal, 20)
    }
}

struct AppleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            .sensoryFeedback(.selection, trigger: configuration.isPressed)
    }
}

#Preview {
    MainButton(title: "Hello", action: { })
}

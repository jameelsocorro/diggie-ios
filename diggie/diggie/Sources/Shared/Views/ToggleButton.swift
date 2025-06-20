//
//  ToggleButton.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import SwiftUI

/// A reusable toggle button component that can display an icon and text with selection states
struct ToggleButton: View {
    let title: String
    let icon: ToggleButtonIcon?
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
            impactFeedback.impactOccurred()
            action()
        }) {
            HStack(spacing: 8) {
                // Icon
                if let icon = icon {
                    Group {
                        switch icon {
                        case .image(let imageName):
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        case .systemImage(let systemName):
                            Image(systemName: systemName)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                    }
                }
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .lineLimit(1)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? Color.white.opacity(0.2) : Color.gray.opacity(0.3))
                    .stroke(isSelected ? Color.white.opacity(0.4) : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

/// Icon types supported by ToggleButton
enum ToggleButtonIcon {
    case image(String)
    case systemImage(String)
}

#Preview {
    VStack(spacing: 16) {
        ToggleButton(
            title: "Threads",
            icon: .image("threads"),
            isSelected: false
        ) {
            print("Threads tapped")
        }
        
        ToggleButton(
            title: "X",
            icon: .image("x"),
            isSelected: true
        ) {
            print("X tapped")
        }
        
        ToggleButton(
            title: "Others",
            icon: .systemImage("ellipsis"),
            isSelected: false
        ) {
            print("Others tapped")
        }
        
        ToggleButton(
            title: "Text Only",
            icon: nil,
            isSelected: false
        ) {
            print("Text only tapped")
        }
    }
    .padding()
    .background(Color.black)
}
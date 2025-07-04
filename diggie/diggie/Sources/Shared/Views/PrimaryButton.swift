//
//  PrimaryButton.swift
//  Diggie
//
//  Created by Jameel Socorro on 19/6/25.
//

import SwiftUI

/// Primary button component used throughout the app for main CTAs
struct PrimaryButton: View {
    
    // MARK: - Properties
    
    /// Button text
    let title: String
    
    /// Button action
    let action: () -> Void
    
    /// Optional accessibility label (defaults to title if not provided)
    let accessibilityLabel: String?
    
    /// Optional accessibility hint
    let accessibilityHint: String?
    
    /// Whether the button is visible (for animations)
    let isVisible: Bool
    
    /// Whether the button is enabled (default: true)
    let isEnabled: Bool
    
    // MARK: - Initializers
    
    /// Initialize with all parameters
    /// - Parameters:
    ///   - title: Button text
    ///   - accessibilityLabel: Optional accessibility label (defaults to title)
    ///   - accessibilityHint: Optional accessibility hint
    ///   - isVisible: Whether button is visible for animations (default: true)
    ///   - isEnabled: Whether button is enabled (default: true)
    ///   - action: Button tap action
    init(
        title: String,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil,
        isVisible: Bool = true,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = accessibilityHint
        self.isVisible = isVisible
        self.isEnabled = isEnabled
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button(action: {
            guard isEnabled else { return }
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
            action()
        }) {
            Text(title)
                .font(.body.weight(.medium))
                .foregroundColor(isEnabled ? .black : .gray)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(isEnabled ? Color.white : Color.white.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(!isEnabled)
        .accessibilityLabel(accessibilityLabel ?? title)
        .accessibilityHint(accessibilityHint ?? (isEnabled ? "Tap to continue" : "Complete the current step to continue"))
        .opacity(isVisible ? 1 : 0)
    }
}

// MARK: - Convenience Initializers

extension PrimaryButton {
    
    /// Initialize with just title and action (most common use case)
    /// - Parameters:
    ///   - title: Button text
    ///   - action: Button tap action
    init(_ title: String, action: @escaping () -> Void) {
        self.init(
            title: title,
            accessibilityLabel: nil,
            accessibilityHint: nil,
            isVisible: true,
            isEnabled: true,
            action: action
        )
    }
    
    /// Initialize with title, action, and visibility state (for animations)
    /// - Parameters:
    ///   - title: Button text
    ///   - isVisible: Whether button is visible
    ///   - action: Button tap action
    init(_ title: String, isVisible: Bool, action: @escaping () -> Void) {
        self.init(
            title: title,
            accessibilityLabel: nil,
            accessibilityHint: nil,
            isVisible: isVisible,
            isEnabled: true,
            action: action
        )
    }
    
    /// Initialize with title, action, and enabled state
    /// - Parameters:
    ///   - title: Button text
    ///   - isEnabled: Whether button is enabled
    ///   - action: Button tap action
    init(_ title: String, isEnabled: Bool, action: @escaping () -> Void) {
        self.init(
            title: title,
            accessibilityLabel: nil,
            accessibilityHint: nil,
            isVisible: true,
            isEnabled: isEnabled,
            action: action
        )
    }
    
    /// Initialize with title, visibility, enabled state, and action
    /// - Parameters:
    ///   - title: Button text
    ///   - isVisible: Whether button is visible
    ///   - isEnabled: Whether button is enabled
    ///   - action: Button tap action
    init(_ title: String, isVisible: Bool, isEnabled: Bool, action: @escaping () -> Void) {
        self.init(
            title: title,
            accessibilityLabel: nil,
            accessibilityHint: nil,
            isVisible: isVisible,
            isEnabled: isEnabled,
            action: action
        )
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        PrimaryButton("Try it for free") {
            print("Button tapped")
        }
        
        PrimaryButton("Continue", isEnabled: false) {
            print("Continue tapped")
        }
        
        PrimaryButton("Continue", isVisible: false) {
            print("Continue tapped")
        }
        
        PrimaryButton(
            title: "Get Started",
            accessibilityLabel: "Get started with Diggie",
            accessibilityHint: "Tap to begin the onboarding process"
        ) {
            print("Get started tapped")
        }
    }
    .padding()
    .background(Color.black)
}
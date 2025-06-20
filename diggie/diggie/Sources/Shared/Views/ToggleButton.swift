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
    let description: String?
    let icon: ToggleButtonIcon?
    let isSelected: Bool
    let configuration: ToggleButtonConfiguration
    let action: () -> Void
    
    init(
        title: String,
        description: String? = nil,
        icon: ToggleButtonIcon? = nil,
        isSelected: Bool,
        configuration: ToggleButtonConfiguration = .default,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.description = description
        self.icon = icon
        self.isSelected = isSelected
        self.configuration = configuration
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
            impactFeedback.impactOccurred()
            action()
        }) {
            HStack(spacing: configuration.contentSpacing) {
                // Icon
                if let icon = icon {
                    Group {
                        switch icon {
                        case .image(let imageName):
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: configuration.iconSize.width, height: configuration.iconSize.height)
                                .foregroundColor(isSelected ? configuration.selectedIconColor : configuration.iconColor)
                        case .systemImage(let systemName):
                            Image(systemName: systemName)
                                .font(.system(size: configuration.iconSize.width, weight: .medium))
                                .foregroundColor(isSelected ? configuration.selectedIconColor : configuration.iconColor)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(configuration.textFont)
                        .fontWeight(.medium)
                        .foregroundColor(isSelected ? configuration.selectedTextColor : configuration.textColor)
                        .lineLimit(1)
                    
                    if let description = description {
                        Text(description)
                            .font(configuration.descriptionFont)
                            .foregroundColor(isSelected ? configuration.selectedDescriptionColor : configuration.descriptionColor)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                if configuration.expandToFillWidth {
                    Spacer()
                }
                
                // Checkmark
                if configuration.showCheckmark && isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
            .padding(.horizontal, configuration.horizontalPadding)
            .padding(.vertical, configuration.verticalPadding)
            .frame(maxWidth: configuration.expandToFillWidth ? .infinity : nil)
            .background(
                RoundedRectangle(cornerRadius: configuration.cornerRadius)
                    .fill(isSelected ? configuration.selectedBackgroundColor : configuration.backgroundColor)
                    .stroke(isSelected ? configuration.selectedBorderColor : configuration.borderColor, lineWidth: configuration.borderWidth)
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

/// Configuration for ToggleButton appearance and behavior
struct ToggleButtonConfiguration {
    let textFont: Font
    let textColor: Color
    let selectedTextColor: Color
    let descriptionFont: Font
    let descriptionColor: Color
    let selectedDescriptionColor: Color
    let iconColor: Color
    let selectedIconColor: Color
    let backgroundColor: Color
    let selectedBackgroundColor: Color
    let borderColor: Color
    let selectedBorderColor: Color
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    let contentSpacing: CGFloat
    let iconSize: CGSize
    let expandToFillWidth: Bool
    let showCheckmark: Bool
    
    init(
        textFont: Font = .subheadline,
        textColor: Color = .white,
        selectedTextColor: Color = .white,
        descriptionFont: Font = .caption,
        descriptionColor: Color = Color.white.opacity(0.7),
        selectedDescriptionColor: Color = Color.white.opacity(0.9),
        iconColor: Color = .white,
        selectedIconColor: Color = .white,
        backgroundColor: Color = Color.gray.opacity(0.3),
        selectedBackgroundColor: Color = Color.white.opacity(0.2),
        borderColor: Color = .clear,
        selectedBorderColor: Color = Color.white.opacity(0.4),
        borderWidth: CGFloat = 1,
        cornerRadius: CGFloat = 20,
        horizontalPadding: CGFloat = 16,
        verticalPadding: CGFloat = 12,
        contentSpacing: CGFloat = 8,
        iconSize: CGSize = CGSize(width: 20, height: 20),
        expandToFillWidth: Bool = false,
        showCheckmark: Bool = false
    ) {
        self.textFont = textFont
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.descriptionFont = descriptionFont
        self.descriptionColor = descriptionColor
        self.selectedDescriptionColor = selectedDescriptionColor
        self.iconColor = iconColor
        self.selectedIconColor = selectedIconColor
        self.backgroundColor = backgroundColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.borderColor = borderColor
        self.selectedBorderColor = selectedBorderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.contentSpacing = contentSpacing
        self.iconSize = iconSize
        self.expandToFillWidth = expandToFillWidth
        self.showCheckmark = showCheckmark
    }
}

// MARK: - Preset Configurations

extension ToggleButtonConfiguration {
    /// Default compact configuration (for platform selection)
    static let `default` = ToggleButtonConfiguration()
    
    /// Full width configuration with checkmarks (for frequency selection)
    static let fullWidth = ToggleButtonConfiguration(
        textFont: .headline,
        textColor: .primary,
        selectedTextColor: .primary,
        descriptionFont: .subheadline,
        descriptionColor: .secondary,
        selectedDescriptionColor: .secondary,
        iconColor: .primary,
        selectedIconColor: .primary,
        borderColor: .clear,
        cornerRadius: 12,
        verticalPadding: 16,
        expandToFillWidth: true,
        showCheckmark: true
    )
}

#Preview {
    VStack(spacing: 16) {
        // Default compact configuration (platform style)
        HStack {
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
        }
        
        // Full width preset configuration (frequency style)
        ToggleButton(
            title: "Daily",
            description: "Post content every day to stay top of mind",
            isSelected: false,
            configuration: .fullWidth
        ) {
            print("Daily tapped")
        }
        
        ToggleButton(
            title: "Few times a week",
            description: "Balance consistency with quality content creation",
            isSelected: true,
            configuration: .fullWidth
        ) {
            print("Few times a week tapped")
        }
        
        // Custom configuration (full width with icon)
        ToggleButton(
            title: "Settings",
            icon: .systemImage("gear"),
            isSelected: false,
            configuration: ToggleButtonConfiguration(
                textFont: .body,
                textColor: .primary,
                selectedTextColor: .white,
                iconColor: .primary,
                selectedIconColor: .white,
                backgroundColor: Color(.systemGray6),
                selectedBackgroundColor: .accentColor,
                cornerRadius: 8,
                expandToFillWidth: true
            )
        ) {
            print("Settings tapped")
        }
    }
    .padding()
    .background(Color.black)
}

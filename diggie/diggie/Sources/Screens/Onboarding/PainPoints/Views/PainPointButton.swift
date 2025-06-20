//
//  PainPointButton.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import SwiftUI

/// Pain point selection button component
struct PainPointButton: View {
    let painPoint: PainPoint
    let isSelected: Bool
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(painPoint.displayName)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(isDisabled ? .secondary : .primary)
                        
                        Text(painPoint.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.accentColor)
                            .font(.title2)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.accentColor.opacity(0.1) : (isDisabled ? Color.gray.opacity(0.1) : Color(.systemGray6)))
                    .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 2)
            )
            .opacity(isDisabled ? 0.6 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isDisabled)
    }
}

#Preview {
    VStack(spacing: 16) {
        PainPointButton(painPoint: .timeManagement, isSelected: false, isDisabled: false) {
            print("Time management tapped")
        }
        
        PainPointButton(painPoint: .consistency, isSelected: true, isDisabled: false) {
            print("Consistency tapped")
        }
        
        PainPointButton(painPoint: .contentIdeas, isSelected: false, isDisabled: true) {
            print("Content ideas tapped")
        }
    }
    .padding()
}
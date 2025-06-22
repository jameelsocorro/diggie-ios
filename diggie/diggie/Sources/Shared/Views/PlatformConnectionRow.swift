//
//  PlatformConnectionRow.swift
//  Diggie
//
//  Created by Jameel Socorro on 22/6/25.
//

import SwiftUI

/// Row for displaying platform connection option
struct PlatformConnectionRow: View {
    let platform: SocialPlatform
    let isConnecting: Bool
    let onConnect: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Platform icon
            Image(platform.iconName)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Platform name
            VStack(alignment: .leading, spacing: 2) {
                Text(platform.displayName)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("Connect your \(platform.displayName) account")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Connect button
            Button(action: onConnect) {
                if isConnecting {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: "plus")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            .frame(width: 40, height: 40)
            .background(Color.accentColor)
            .clipShape(Circle())
            .disabled(isConnecting)
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    PlatformConnectionRow(
        platform: SocialPlatform.threads,
        isConnecting: false,
        onConnect: { print("Connect tapped") }
    )
    .padding()
}

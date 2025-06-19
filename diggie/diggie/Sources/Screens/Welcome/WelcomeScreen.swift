//
//  WelcomeScreen.swift
//  Diggie
//
//  Created by Jameel Socorro on 19/6/25.
//

import SwiftUI

/// Welcome screen displaying the app's value proposition and main CTA
struct WelcomeScreen: View {
    
    let viewModel: WelcomeScreenViewModel
    
    var body: some View {
        ZStack {
            // Gradient background matching the mockup
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.15, green: 0.1, blue: 0.2),   // Dark purple
                    Color.black
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Logo section
                VStack(spacing: 16) {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .accessibilityLabel("Diggie Logo")
                    
                    Text("Diggie")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .accessibilityLabel("Diggie")
                }
                
                Spacer()
                
                                // Value proposition section
                VStack(alignment: .leading, spacing: 4) {
                    Text("One post.")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Everywhere. Instantly.")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.gray)
                        .opacity(0.8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 40)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("One post. Everywhere. Instantly.")
                .accessibilityHint("Diggie's value proposition: post to multiple platforms at once")
                
                
                // CTA Button
                Button(action: {
                    viewModel.handleCTATap()
                }) {
                    Text("Try it for free")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .accessibilityLabel("Try it for free")
                .accessibilityHint("Tap to start using Diggie")
                
                Spacer()
                    .frame(height: 16)
            }
            .padding(.horizontal, 22)
        }
        .supportsDynamicType()
    }
}

/// Custom modifier to support Dynamic Type
private struct SupportsDynamicType: ViewModifier {
    func body(content: Content) -> some View {
        content
            .dynamicTypeSize(...DynamicTypeSize.accessibility3)
    }
}

private extension View {
    func supportsDynamicType() -> some View {
        modifier(SupportsDynamicType())
    }
}

#Preview {
    WelcomeScreen(viewModel: WelcomeScreenViewModel { })
}

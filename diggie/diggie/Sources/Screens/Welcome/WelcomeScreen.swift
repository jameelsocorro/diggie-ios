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
                
                // Logo section with slide up + fade animation
                Image("LogoFull")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .accessibilityLabel("Diggie Logo with title")
                    .opacity(viewModel.logoVisible ? 1 : 0)
                    .offset(y: viewModel.logoVisible ? 0 : 30)
                    .scaleEffect(viewModel.logoVisible ? 1 : 0.8)
                
                Spacer()
                
                // Value proposition section with slide left + fade animation
                VStack(alignment: .leading, spacing: 4) {
                    Text("One post.")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                    
                    Text("Everywhere. Instantly.")
                        .font(.title2.weight(.bold))
                        .foregroundColor(.gray)
                        .opacity(0.8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 40)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("One post. Everywhere. Instantly.")
                .accessibilityHint("Diggie's value proposition: post to multiple platforms at once")
                .opacity(viewModel.taglineVisible ? 1 : 0)
                .offset(x: viewModel.taglineVisible ? 0 : -50)
                
                
                // CTA Button with slide up + fade animation
                PrimaryButton(
                    title: "Try it for free",
                    accessibilityLabel: "Try it for free",
                    accessibilityHint: "Tap to start using Diggie",
                    isVisible: viewModel.ctaButtonVisible
                ) {
                    viewModel.handleCTATap()
                }
                
                Spacer()
                    .frame(height: 24)
            }
            .padding(.horizontal, 22)
        }
        .supportsDynamicType()
        .onAppear {
            viewModel.startAnimations()
        }
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

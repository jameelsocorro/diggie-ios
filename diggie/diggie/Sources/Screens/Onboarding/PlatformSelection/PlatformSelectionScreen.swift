//
//  PlatformSelectionScreen.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import SwiftUI

/// Onboarding Screen 1: Platform Selection
struct PlatformSelectionScreen: View {
    
    let viewModel: PlatformSelectionScreenViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer().frame(height: 24)
            
            // Header with slide down + fade animation
            VStack(alignment: .leading, spacing: 12) {
                Text("Which platforms do you use?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: 300, alignment: .leading)
                
                Text("This would help me understand which platform integrations to prioritize.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: 300, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .opacity(viewModel.headerVisible ? 1 : 0)
            
            Spacer()
            
            // Platform options with slide up + fade animation
            FlexWrapLayout(spacing: 8) {
                ForEach(viewModel.availablePlatforms) { platform in
                    ToggleButton(
                        title: platform.displayName,
                        icon: platform.iconName.map { .image($0) } ?? .systemImage("ellipsis"),
                        isSelected: viewModel.isPlatformSelected(platform)
                    ) {
                        viewModel.togglePlatform(platform)
                    }
                }
            }
            .padding(.horizontal)
            .opacity(viewModel.platformsVisible ? 1 : 0)
            .offset(x: viewModel.platformsVisible ? 0 : -50)            
            
            Spacer()            
            
            // Continue button with slide up + fade animation
            VStack(spacing: 16) {
                PrimaryButton(
                    "Continue",
                    isVisible: viewModel.continueButtonVisible,
                    isEnabled: viewModel.canContinue
                ) {
                    withAnimation {
                        viewModel.continueToNextStep()
                    }
                }
                .padding(.horizontal)
                
                // Step indicator
                Text(viewModel.stepIndicator)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom)
            .opacity(viewModel.continueButtonVisible ? 1 : 0)
            .offset(y: viewModel.continueButtonVisible ? 0 : 30)
            .scaleEffect(viewModel.continueButtonVisible ? 1 : 0.9)
        }
        .onAppear {
            if viewModel.isActive {
                viewModel.startAnimations()
            }
        }
        .onChange(of: viewModel.isActive) { _, isActive in
            if isActive {
                viewModel.startAnimations()
            }
        }
    }
}

#Preview {
    let service = OnboardingService()
    let viewModel = PlatformSelectionScreenViewModel(onboardingService: service)
    return PlatformSelectionScreen(viewModel: viewModel)
}

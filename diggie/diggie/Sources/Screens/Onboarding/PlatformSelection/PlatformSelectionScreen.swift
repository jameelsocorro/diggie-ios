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
            Spacer()
            
            // Header
            VStack(alignment: .leading, spacing: 12) {
                Text("Which platforms do you use?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: 300, alignment: .leading)
                
                Text("This would help me understand which platform integrations to prioritize.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Spacer()
            
            // Platform options with dynamic wrapping layout
            FlexWrapLayout(spacing: 8) {
                ForEach(viewModel.availablePlatforms) { platform in
                    PlatformButton(
                        platform: platform,
                        isSelected: viewModel.isPlatformSelected(platform)
                    ) {
                        viewModel.togglePlatform(platform)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Continue button
            VStack(spacing: 16) {
                PrimaryButton(
                    "Continue",
                    isVisible: viewModel.canContinue
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
        }
    }
}

#Preview {
    let service = OnboardingService()
    let viewModel = PlatformSelectionScreenViewModel(onboardingService: service)
    return PlatformSelectionScreen(viewModel: viewModel)
}

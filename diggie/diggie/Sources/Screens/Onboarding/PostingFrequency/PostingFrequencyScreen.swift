//
//  PostingFrequencyScreen.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import SwiftUI

/// Onboarding Screen 2: Posting Frequency
struct PostingFrequencyScreen: View {
    
    let viewModel: PostingFrequencyScreenViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer().frame(height: 24)
            
            // Header
            VStack(alignment: .leading, spacing: 12) {
                Text("How often do you post?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: 300, alignment: .leading)
                
                Text("This helps me understand your workflow.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: 300, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Spacer()
            
            // Frequency options
            VStack(spacing: 16) {
                ForEach(viewModel.availableFrequencies) { frequency in
                    ToggleButton(
                        title: frequency.displayName,
                        isSelected: viewModel.isFrequencySelected(frequency),
                        configuration: .fullWidth
                    ) {
                        viewModel.selectFrequency(frequency)
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
    let viewModel = PostingFrequencyScreenViewModel(onboardingService: service)
    return PostingFrequencyScreen(viewModel: viewModel)
}

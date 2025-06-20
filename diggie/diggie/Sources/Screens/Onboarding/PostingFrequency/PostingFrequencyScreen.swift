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
                    .frame(maxWidth: 200, alignment: .leading)
                
                Text("This helps me understand your workflow.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: 300, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .opacity(viewModel.headerVisible ? 1 : 0)
            
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
            .opacity(viewModel.frequenciesVisible ? 1 : 0)
            .offset(y: viewModel.frequenciesVisible ? 0 : 50)            
            
            Spacer()
            
            // Step indicator
            Text(viewModel.stepIndicator)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom)
                .opacity(viewModel.stepIndicatorVisible ? 1 : 0)
                .offset(y: viewModel.stepIndicatorVisible ? 0 : 30)
                .scaleEffect(viewModel.stepIndicatorVisible ? 1 : 0.9)
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
    let viewModel = PostingFrequencyScreenViewModel(onboardingService: service)
    return PostingFrequencyScreen(viewModel: viewModel)
}

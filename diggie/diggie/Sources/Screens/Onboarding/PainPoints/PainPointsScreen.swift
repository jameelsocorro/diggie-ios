//
//  PainPointsScreen.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import SwiftUI

/// Onboarding Screen 4: Pain Points Selection
struct PainPointsScreen: View {
    
    let viewModel: PainPointsScreenViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Header
            VStack(spacing: 12) {
                Text("What's your biggest challenge?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("This helps me solve your most important problems first.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Pain point options
            VStack(spacing: 16) {
                ForEach(viewModel.availablePainPoints) { painPoint in
                    PainPointButton(
                        painPoint: painPoint,
                        isSelected: viewModel.isPainPointSelected(painPoint),
                        isDisabled: viewModel.isPainPointDisabled(painPoint)
                    ) {
                        viewModel.togglePainPoint(painPoint)
                    }
                }
            }
            .padding(.horizontal)
            
            // Selection guidance
            if viewModel.shouldShowGuidance {
                Text(viewModel.selectionGuidance)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
            
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
    let viewModel = PainPointsScreenViewModel(onboardingService: service)
    return PainPointsScreen(viewModel: viewModel)
}

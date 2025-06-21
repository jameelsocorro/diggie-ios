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
            Spacer().frame(height: 24)
            
            // Header
            VStack(alignment: .leading, spacing: 12) {
                Text("What's your biggest challenge?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: 350, alignment: .leading)
                
                Text("This helps me solve your most important problems first.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: 300, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .opacity(viewModel.headerVisible ? 1 : 0)
            
            Spacer().frame(height: 24)
            
            // Pain point options
            VStack(spacing: 16) {
                ForEach(viewModel.availablePainPoints) { painPoint in
                    ToggleButton(
                        title: painPoint.displayName,
                        description: painPoint.description,
                        isSelected: viewModel.isPainPointSelected(painPoint),
                        configuration: .fullWidth
                    ) {
                        viewModel.togglePainPoint(painPoint)
                    }
                    .disabled(viewModel.isPainPointDisabled(painPoint))
                    .opacity(viewModel.isPainPointDisabled(painPoint) ? 0.5 : 1.0)
                }
            }
            .padding(.horizontal)
            .opacity(viewModel.painPointsVisible ? 1 : 0)
            .offset(y: viewModel.painPointsVisible ? 0 : 50)
            
            Text(viewModel.selectionGuidance)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .opacity(viewModel.guidanceVisible ? 1 : 0)
                .offset(y: viewModel.guidanceVisible ? 0 : 20)
            
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
    let viewModel = PainPointsScreenViewModel(onboardingService: service)
    return PainPointsScreen(viewModel: viewModel)
}

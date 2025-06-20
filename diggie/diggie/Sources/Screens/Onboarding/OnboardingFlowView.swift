//
//  OnboardingFlowView.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import SwiftUI

/// Main onboarding flow coordinator view
struct OnboardingFlowView: View {
    
    @State private var onboardingService = OnboardingService()
    @Environment(DiggieAppViewModel.self) private var appViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Dark background matching mockup
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    // Progress bar with back button
                    HStack {
                        Button(action: {
                            if onboardingService.currentStep > 1 {
                                onboardingService.previousStep()
                            } else {
                                // Go back to welcome screen from first onboarding step
                                appViewModel.navigateToScreen(.welcome)
                            }
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        ProgressView(value: onboardingService.progress)
                            .progressViewStyle(LinearProgressViewStyle(tint: .white))
                        
                        Spacer()
                            .frame(width: 24) // Balance layout
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Current onboarding screen
                    Group {
                        switch onboardingService.currentStep {
                        case 1:
                            PlatformSelectionScreen(
                                viewModel: PlatformSelectionScreenViewModel(onboardingService: onboardingService)
                            )
                        case 2:
                            PostingFrequencyScreen(
                                viewModel: PostingFrequencyScreenViewModel(onboardingService: onboardingService)
                            )
                        case 3:
                            ContentTypeScreen(
                                viewModel: ContentTypeScreenViewModel(onboardingService: onboardingService)
                            )
                        case 4:
                            PainPointsScreen(
                                viewModel: PainPointsScreenViewModel(onboardingService: onboardingService)
                            )
                        case 5:
                            PricingScreen(
                                viewModel: PricingScreenViewModel(onboardingService: onboardingService)
                            )
                        default:
                            PlatformSelectionScreen(
                                viewModel: PlatformSelectionScreenViewModel(onboardingService: onboardingService)
                            )
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: onboardingService.currentStep)
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .onboardingCompleted)) { _ in
            appViewModel.navigateToScreen(.main)
        }
    }
}

#Preview {
    OnboardingFlowView()
        .environment(DiggieAppViewModel())
}
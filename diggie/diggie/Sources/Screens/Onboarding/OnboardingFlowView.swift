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
                        if onboardingService.currentStep > 1 {
                            Button(action: {
                                onboardingService.previousStep()
                            }) {
                                Image(systemName: "arrow.left")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        ProgressView(value: onboardingService.progress)
                            .progressViewStyle(LinearProgressViewStyle(tint: .white))
                        
                        // Spacer to balance layout when no back button
                        if onboardingService.currentStep == 1 {
                            Spacer()
                                .frame(width: 24) // Same width as back button
                        }
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
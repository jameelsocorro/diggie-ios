//
//  OnboardingFlowView.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import SwiftUI

/// Main onboarding flow coordinator view
struct OnboardingFlowView: View {
    
    @State private var viewModel = OnboardingFlowViewModel()
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
                            if viewModel.canGoBack {
                                viewModel.navigateBackward()
                            } else {
                                // Go back to welcome screen from first onboarding step
                                appViewModel.navigateToScreen(.welcome)
                            }
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        ProgressView(value: viewModel.progress)
                            .progressViewStyle(LinearProgressViewStyle(tint: .purple))
                        
                        Spacer()
                            .frame(width: 24) // Balance layout
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Current step content (lazy loaded)
                    Group {
                        switch viewModel.currentStep {
                        case 1:
                            PlatformSelectionScreen(viewModel: viewModel.platformSelectionViewModel)
                        case 2:
                            PostingFrequencyScreen(viewModel: viewModel.postingFrequencyViewModel)
                        case 3:
                            ContentTypeScreen(viewModel: viewModel.contentTypeViewModel)
                        case 4:
                            PainPointsScreen(viewModel: viewModel.painPointsViewModel)
                        case 5:
                            PricingScreen(viewModel: viewModel.pricingViewModel)
                        default:
                            PlatformSelectionScreen(viewModel: viewModel.platformSelectionViewModel)
                        }
                    }
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                    .animation(.easeInOut(duration: 0.4), value: viewModel.currentStep)
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
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
                    
                    // Sliding container for smooth navigation
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            // Step 1: Platform Selection
                            PlatformSelectionScreen(viewModel: viewModel.platformSelectionViewModel)
                                .frame(width: geometry.size.width)
                            
                            // Step 2: Posting Frequency
                            PostingFrequencyScreen(viewModel: viewModel.postingFrequencyViewModel)
                                .frame(width: geometry.size.width)
                            
                            // Step 3: Content Type
                            ContentTypeScreen(viewModel: viewModel.contentTypeViewModel)
                                .frame(width: geometry.size.width)
                            
                            // Step 4: Pain Points
                            PainPointsScreen(viewModel: viewModel.painPointsViewModel)
                                .frame(width: geometry.size.width)
                            
                            // Step 5: Pricing
                            PricingScreen(viewModel: viewModel.pricingViewModel)
                                .frame(width: geometry.size.width)
                        }
                        .offset(x: viewModel.slideOffset)
                        .animation(.easeInOut(duration: 0.4), value: viewModel.slideOffset)
                    }
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
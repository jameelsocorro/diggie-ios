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
    
    // Persistent ViewModels to prevent recreation on service updates
    @State private var platformSelectionViewModel: PlatformSelectionScreenViewModel?
    @State private var postingFrequencyViewModel: PostingFrequencyScreenViewModel?
    @State private var contentTypeViewModel: ContentTypeScreenViewModel?
    @State private var painPointsViewModel: PainPointsScreenViewModel?
    @State private var pricingViewModel: PricingScreenViewModel?
    
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
                            if let viewModel = platformSelectionViewModel {
                                PlatformSelectionScreen(viewModel: viewModel)
                                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            }
                        case 2:
                            if let viewModel = postingFrequencyViewModel {
                                PostingFrequencyScreen(viewModel: viewModel)
                                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            }
                        case 3:
                            if let viewModel = contentTypeViewModel {
                                ContentTypeScreen(viewModel: viewModel)
                                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            }
                        case 4:
                            if let viewModel = painPointsViewModel {
                                PainPointsScreen(viewModel: viewModel)
                                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            }
                        case 5:
                            if let viewModel = pricingViewModel {
                                PricingScreen(viewModel: viewModel)
                                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            }
                        default:
                            if let viewModel = platformSelectionViewModel {
                                PlatformSelectionScreen(viewModel: viewModel)
                                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            }
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: onboardingService.currentStep)
                }
            }
        }
        .onAppear {
            setupViewModels()
        }
        .onReceive(NotificationCenter.default.publisher(for: .onboardingCompleted)) { _ in
            appViewModel.navigateToScreen(.main)
        }
    }
    
    // MARK: - Private Methods
    
    /// Setup ViewModels once to prevent recreation on service updates
    private func setupViewModels() {
        if platformSelectionViewModel == nil {
            platformSelectionViewModel = PlatformSelectionScreenViewModel(onboardingService: onboardingService)
        }
        if postingFrequencyViewModel == nil {
            postingFrequencyViewModel = PostingFrequencyScreenViewModel(onboardingService: onboardingService)
        }
        if contentTypeViewModel == nil {
            contentTypeViewModel = ContentTypeScreenViewModel(onboardingService: onboardingService)
        }
        if painPointsViewModel == nil {
            painPointsViewModel = PainPointsScreenViewModel(onboardingService: onboardingService)
        }
        if pricingViewModel == nil {
            pricingViewModel = PricingScreenViewModel(onboardingService: onboardingService)
        }
    }
}

#Preview {
    OnboardingFlowView()
        .environment(DiggieAppViewModel())
}
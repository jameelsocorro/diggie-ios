//
//  OnboardingFlowViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import Foundation
import UIKit
import SwiftUI

/// ViewModel for managing the overall onboarding flow and navigation
@Observable
@MainActor
final class OnboardingFlowViewModel {
    
    // MARK: - Dependencies
    
    private let onboardingService = OnboardingService()
    
    // MARK: - Published Properties
    
    /// Current slide offset for smooth transitions
    var slideOffset: CGFloat = 0
    
    // MARK: - Persistent ViewModels
    
    /// Platform selection ViewModel (Step 1)
    private var _platformSelectionViewModel: PlatformSelectionScreenViewModel?
    var platformSelectionViewModel: PlatformSelectionScreenViewModel {
        if _platformSelectionViewModel == nil {
            _platformSelectionViewModel = PlatformSelectionScreenViewModel(onboardingService: onboardingService, navigateForward: navigateForward)
        }
        return _platformSelectionViewModel!
    }
    
    /// Posting frequency ViewModel (Step 2)
    private var _postingFrequencyViewModel: PostingFrequencyScreenViewModel?
    var postingFrequencyViewModel: PostingFrequencyScreenViewModel {
        if _postingFrequencyViewModel == nil {
            _postingFrequencyViewModel = PostingFrequencyScreenViewModel(onboardingService: onboardingService, navigateForward: navigateForward)
        }
        return _postingFrequencyViewModel!
    }
    
    /// Content type ViewModel (Step 3)
    private var _contentTypeViewModel: ContentTypeScreenViewModel?
    var contentTypeViewModel: ContentTypeScreenViewModel {
        if _contentTypeViewModel == nil {
            _contentTypeViewModel = ContentTypeScreenViewModel(onboardingService: onboardingService, navigateForward: navigateForward)
        }
        return _contentTypeViewModel!
    }
    
    /// Pain points ViewModel (Step 4)
    private var _painPointsViewModel: PainPointsScreenViewModel?
    var painPointsViewModel: PainPointsScreenViewModel {
        if _painPointsViewModel == nil {
            _painPointsViewModel = PainPointsScreenViewModel(onboardingService: onboardingService, navigateForward: navigateForward)
        }
        return _painPointsViewModel!
    }
    
    /// Pricing ViewModel (Step 5)
    private var _pricingViewModel: PricingScreenViewModel?
    var pricingViewModel: PricingScreenViewModel {
        if _pricingViewModel == nil {
            _pricingViewModel = PricingScreenViewModel(onboardingService: onboardingService)
        }
        return _pricingViewModel!
    }
    
    // MARK: - Computed Properties
    
    /// Current onboarding step
    var currentStep: Int {
        onboardingService.currentStep
    }
    
    /// Progress percentage (0.0 to 1.0)
    var progress: Double {
        onboardingService.progress
    }
    
    /// Whether we can go back from current step
    var canGoBack: Bool {
        currentStep > 1
    }
    
    // MARK: - Initialization
    
    /// Initialize the onboarding flow ViewModel
    init() {
        updateSlideOffset()
    }
    
    // MARK: - Public Methods
    
    /// Navigate to previous step with proper animation
    func navigateBackward() {
        guard canGoBack else { return }
        onboardingService.previousStep()
        updateSlideOffset()
    }
    
    /// Complete onboarding and navigate to main app
    func completeOnboarding(navigateToMain: @escaping () -> Void) {
        onboardingService.completeOnboarding()
        navigateToMain()
    }
    
    // MARK: - Private Methods
    
    /// Navigate to next step with proper animation
    private func navigateForward() {
        guard onboardingService.canProceedFromCurrentStep && currentStep < 5 else { return }
        onboardingService.nextStep()
        updateSlideOffset()
    }
    
    /// Update slide offset based on current step
    private func updateSlideOffset() {
        let screenWidth = UIScreen.main.bounds.width
        slideOffset = -CGFloat(currentStep - 1) * screenWidth
    }
}
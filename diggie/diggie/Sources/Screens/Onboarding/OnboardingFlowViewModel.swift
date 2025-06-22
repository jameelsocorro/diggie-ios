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
    
    // MARK: - Haptic Feedback
    
    /// Haptic feedback generators (prepared for optimal performance)
    private let softImpactGenerator = UIImpactFeedbackGenerator(style: .soft)

    // MARK: - Published Properties
    
    /// Tracks which steps have been initialized for sliding window
    var initializedSteps: Set<Int> = [1]
    
    /// Tracks navigation direction for proper animation
    var isNavigatingBackward: Bool = false
    
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
    
    /// OS Preference ViewModel (Step 5)
    private var _osPreferenceViewModel: OSPreferenceScreenViewModel?
    var osPreferenceViewModel: OSPreferenceScreenViewModel {
        if _osPreferenceViewModel == nil {
            _osPreferenceViewModel = OSPreferenceScreenViewModel(onboardingService: onboardingService)
        }
        return _osPreferenceViewModel!
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
    
    /// Current step's index in the initialized steps array
    var currentStepIndex: Int {
        Array(initializedSteps).sorted().firstIndex(of: currentStep) ?? 0
    }
    
    /// Container offset for sliding window animation
    func containerOffset(screenWidth: CGFloat) -> CGFloat {
        -screenWidth * CGFloat(currentStepIndex)
    }
    
    // MARK: - Initialization
    
    /// Initialize the onboarding flow ViewModel
    init() {
        updateActiveScreens()
        
        // Prepare haptic feedback generators for optimal performance
        softImpactGenerator.prepare()
    }
    
    // MARK: - Public Methods
    
    /// Navigate to previous step with proper animation
    func navigateBackward() {
        guard canGoBack else { return }
        isNavigatingBackward = true
        
        // Add previous step to initialized set if not already present
        let previousStep = currentStep - 1
        if previousStep > 0 {
            initializedSteps.insert(previousStep)
        }
        
        onboardingService.previousStep()
        updateActiveScreens()
        softImpactGenerator.impactOccurred()
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
        isNavigatingBackward = false
        
        // Add next step to initialized set before navigation
        let nextStep = currentStep + 1
        initializedSteps.insert(nextStep)
        
        onboardingService.nextStep()
        updateActiveScreens()
    }
    
    /// Update which screen is currently active
    private func updateActiveScreens() {
        // Reset all created screens to inactive
        _platformSelectionViewModel?.updateActiveState(false)
        _postingFrequencyViewModel?.updateActiveState(false)
        _contentTypeViewModel?.updateActiveState(false)
        _painPointsViewModel?.updateActiveState(false)
        _osPreferenceViewModel?.updateActiveState(false)
        
        // Set current screen as active (this will create it if needed)
        switch currentStep {
        case 1:
            platformSelectionViewModel.updateActiveState(true)
        case 2:
            postingFrequencyViewModel.updateActiveState(true)
        case 3:
            contentTypeViewModel.updateActiveState(true)
        case 4:
            painPointsViewModel.updateActiveState(true)
        case 5:
            osPreferenceViewModel.updateActiveState(true)
        default:
            break
        }
    }
}
//
//  PostingFrequencyScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import Foundation
import SwiftUI

/// ViewModel for Posting Frequency screen (Onboarding Step 2)
@Observable
@MainActor
final class PostingFrequencyScreenViewModel {
    
    // MARK: - Dependencies
    
    private let onboardingService: OnboardingService
    private let navigateForward: (() -> Void)?
    
    // MARK: - Haptic Feedback
    
    /// Haptic feedback generators (prepared for optimal performance)
    private let softImpactGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    // MARK: - Published Properties
    
    /// Currently selected posting frequency
    var selectedFrequency: PostingFrequency?
    
    /// Whether the continue button should be enabled
    var canContinue: Bool = false
    
    /// Whether the header is visible
    var headerVisible: Bool = false
    
    /// Whether the frequency options are visible
    var frequenciesVisible: Bool = false
    
    /// Whether the continue button is visible
    var stepIndicatorVisible: Bool = false

    // MARK: - Computed Properties
    
    /// Available frequency options
    var availableFrequencies: [PostingFrequency] {
        PostingFrequency.allCases
    }
    
    /// Progress for this step (40%)
    var progress: Double {
        0.4
    }
    
    /// Step indicator text
    var stepIndicator: String {
        "Step 2 of 5"
    }
    
    // MARK: - Initialization
    
    /// Initialize with onboarding service dependency
    /// - Parameters:
    ///   - onboardingService: Service managing onboarding flow
    ///   - navigateForward: Optional callback for forward navigation with proper animation
    init(onboardingService: OnboardingService, navigateForward: (() -> Void)? = nil) {
        self.onboardingService = onboardingService
        self.navigateForward = navigateForward
        loadExistingData()
        softImpactGenerator.prepare()
    }
    
    // MARK: - Public Methods
    
    /// Select a posting frequency
    /// - Parameter frequency: Frequency to select
    func selectFrequency(_ frequency: PostingFrequency) {
        selectedFrequency = frequency
        updateContinueState()
        syncWithService()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                self.continueToNextStep()
            }
        }
    }
    
    /// Check if a frequency is selected
    /// - Parameter frequency: Frequency to check
    /// - Returns: Whether the frequency is selected
    func isFrequencySelected(_ frequency: PostingFrequency) -> Bool {
        selectedFrequency == frequency
    }
    
    /// Proceed to next step
    func continueToNextStep() {
        guard canContinue else { return }
        if let navigateForward = navigateForward {
            navigateForward()
        } else {
            onboardingService.nextStep()
        }
    }

    /// Start the entrance animations with staggered timing
    func startAnimations() {        
        
        withAnimation(.easeOut(duration: 0.2)) {
            headerVisible = true
        }
      
        // Schedule haptic feedback for when platform buttons animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.softImpactGenerator.impactOccurred()
        }

        // Platform buttons animation - 0.3s delay + 0.3s duration = finishes at 0.6s
        withAnimation(.easeOut(duration: 0.3).delay(0.3)) {
            frequenciesVisible = true
        }
                    
        // Schedule haptic feedback for when continue button animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.softImpactGenerator.impactOccurred()
        }

        // Continue button animation - 0.3s delay + 0.5s duration = finishes at 0.8s
        withAnimation(.easeOut(duration: 0.5).delay(0.3)) {
            stepIndicatorVisible = true
        }
    }
    
    // MARK: - Private Methods
    
    /// Load existing data from service
    private func loadExistingData() {
        selectedFrequency = onboardingService.postingFrequency
        updateContinueState()
    }
    
    /// Update continue button state based on selection
    private func updateContinueState() {
        canContinue = selectedFrequency != nil
    }
    
    /// Sync current selection with the onboarding service
    private func syncWithService() {
        onboardingService.updatePostingFrequency(selectedFrequency)
    }
}
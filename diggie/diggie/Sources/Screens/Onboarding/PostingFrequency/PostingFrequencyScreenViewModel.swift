//
//  PostingFrequencyScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import Foundation

/// ViewModel for Posting Frequency screen (Onboarding Step 2)
@Observable
@MainActor
final class PostingFrequencyScreenViewModel {
    
    // MARK: - Dependencies
    
    private let onboardingService: OnboardingService
    
    // MARK: - Published Properties
    
    /// Currently selected posting frequency
    var selectedFrequency: PostingFrequency?
    
    /// Whether the continue button should be enabled
    var canContinue: Bool = false
    
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
    /// - Parameter onboardingService: Service managing onboarding flow
    init(onboardingService: OnboardingService) {
        self.onboardingService = onboardingService
        loadExistingData()
    }
    
    // MARK: - Public Methods
    
    /// Select a posting frequency
    /// - Parameter frequency: Frequency to select
    func selectFrequency(_ frequency: PostingFrequency) {
        selectedFrequency = frequency
        updateContinueState()
        syncWithService()
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
        onboardingService.nextStep()
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
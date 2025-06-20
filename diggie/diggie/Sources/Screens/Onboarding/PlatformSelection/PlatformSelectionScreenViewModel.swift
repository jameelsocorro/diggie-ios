//
//  PlatformSelectionScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import Foundation

/// ViewModel for Platform Selection screen (Onboarding Step 1)
@Observable
@MainActor
final class PlatformSelectionScreenViewModel {
    
    // MARK: - Dependencies
    
    private let onboardingService: OnboardingService
    
    // MARK: - Published Properties
    
    /// Currently selected platforms
    var selectedPlatforms: Set<Platform> = []
    
    /// Whether the continue button should be enabled
    var canContinue: Bool = false
    
    // MARK: - Computed Properties
    
    /// Available platforms for selection
    var availablePlatforms: [Platform] {
        Platform.allCases
    }
    
    /// Progress for this step (20%)
    var progress: Double {
        0.2
    }
    
    /// Step indicator text
    var stepIndicator: String {
        "Step 1 of 5"
    }
    
    // MARK: - Initialization
    
    /// Initialize with onboarding service dependency
    /// - Parameter onboardingService: Service managing onboarding flow
    init(onboardingService: OnboardingService) {
        self.onboardingService = onboardingService
        loadExistingData()
    }
    
    // MARK: - Public Methods
    
    /// Toggle platform selection
    /// - Parameter platform: Platform to toggle
    func togglePlatform(_ platform: Platform) {
        if selectedPlatforms.contains(platform) {
            selectedPlatforms.remove(platform)
        } else {
            selectedPlatforms.insert(platform)
        }
        updateContinueState()
        syncWithService()
    }
    
    /// Check if a platform is selected
    /// - Parameter platform: Platform to check
    /// - Returns: Whether the platform is selected
    func isPlatformSelected(_ platform: Platform) -> Bool {
        selectedPlatforms.contains(platform)
    }
    
    /// Proceed to next step
    func continueToNextStep() {
        guard canContinue else { return }
        onboardingService.nextStep()
    }
    
    // MARK: - Private Methods
    
    /// Load existing data from service
    private func loadExistingData() {
        selectedPlatforms = onboardingService.selectedPlatforms
        updateContinueState()
    }
    
    /// Update continue button state based on selections
    private func updateContinueState() {
        canContinue = !selectedPlatforms.isEmpty
    }
    
    /// Sync current selections with the onboarding service
    private func syncWithService() {
        onboardingService.updateSelectedPlatforms(selectedPlatforms)
    }
}
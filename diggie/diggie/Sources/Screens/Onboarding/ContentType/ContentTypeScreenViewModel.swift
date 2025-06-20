//
//  ContentTypeScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import Foundation

/// ViewModel for Content Type screen (Onboarding Step 3)
@Observable
@MainActor
final class ContentTypeScreenViewModel {
    
    // MARK: - Dependencies
    
    private let onboardingService: OnboardingService
    
    // MARK: - Published Properties
    
    /// Currently selected content types
    var selectedContentTypes: Set<ContentType> = []
    
    /// Whether the continue button should be enabled
    var canContinue: Bool = false
    
    // MARK: - Computed Properties
    
    /// Available content type options
    var availableContentTypes: [ContentType] {
        ContentType.allCases
    }
    
    /// Progress for this step (60%)
    var progress: Double {
        0.6
    }
    
    /// Step indicator text
    var stepIndicator: String {
        "Step 3 of 5"
    }
    
    // MARK: - Initialization
    
    /// Initialize with onboarding service dependency
    /// - Parameter onboardingService: Service managing onboarding flow
    init(onboardingService: OnboardingService) {
        self.onboardingService = onboardingService
        loadExistingData()
    }
    
    // MARK: - Public Methods
    
    /// Toggle content type selection
    /// - Parameter contentType: Content type to toggle
    func toggleContentType(_ contentType: ContentType) {
        if selectedContentTypes.contains(contentType) {
            selectedContentTypes.remove(contentType)
        } else {
            selectedContentTypes.insert(contentType)
        }
        updateContinueState()
        syncWithService()
    }
    
    /// Check if a content type is selected
    /// - Parameter contentType: Content type to check
    /// - Returns: Whether the content type is selected
    func isContentTypeSelected(_ contentType: ContentType) -> Bool {
        selectedContentTypes.contains(contentType)
    }
    
    /// Proceed to next step
    func continueToNextStep() {
        guard canContinue else { return }
        onboardingService.nextStep()
    }
    
    // MARK: - Private Methods
    
    /// Load existing data from service
    private func loadExistingData() {
        selectedContentTypes = onboardingService.selectedContentTypes
        updateContinueState()
    }
    
    /// Update continue button state based on selections
    private func updateContinueState() {
        canContinue = !selectedContentTypes.isEmpty
    }
    
    /// Sync current selections with the onboarding service
    private func syncWithService() {
        onboardingService.updateSelectedContentTypes(selectedContentTypes)
    }
}
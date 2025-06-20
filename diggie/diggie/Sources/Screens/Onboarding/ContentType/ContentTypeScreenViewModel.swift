//
//  ContentTypeScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import Foundation
import SwiftUI

/// ViewModel for Content Type screen (Onboarding Step 3)
@Observable
@MainActor
final class ContentTypeScreenViewModel {
    
    // MARK: - Dependencies
    
    private let onboardingService: OnboardingService
    private let navigateForward: (() -> Void)?
    
    // MARK: - Haptic Feedback
    
    /// Haptic feedback generators (prepared for optimal performance)
    private let softImpactGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    // MARK: - Published Properties
    
    /// Currently selected content types
    var selectedContentTypes: Set<ContentType> = []
    
    /// Whether the continue button should be enabled
    var canContinue: Bool = false
    
    /// Whether this screen is currently active for animations
    var isActive: Bool = false
    
    /// Whether the header is visible
    var headerVisible: Bool = false
    
    /// Whether the content type options are visible
    var contentTypesVisible: Bool = false
    
    /// Whether the step indicator is visible
    var stepIndicatorVisible: Bool = false
    
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
    
    /// Toggle content type selection
    /// - Parameter contentType: Content type to toggle
    func toggleContentType(_ contentType: ContentType) {
        if selectedContentTypes.contains(contentType) {
            selectedContentTypes.remove(contentType)
        } else {
            selectedContentTypes.insert(contentType)
        }
        softImpactGenerator.impactOccurred()
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
        if let navigateForward = navigateForward {
            navigateForward()
        } else {
            onboardingService.nextStep()
        }
    }
    
    /// Update the active state for animation control
    /// - Parameter isActive: Whether this screen is currently active
    func updateActiveState(_ isActive: Bool) {
        self.isActive = isActive
    }
    
    /// Start animations for this screen
    func startAnimations() {
        guard isActive else { return }
        
        withAnimation(.easeOut(duration: 0.2)) {
            headerVisible = true
        }
      
        // Schedule haptic feedback for when content type buttons animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.softImpactGenerator.impactOccurred()
        }

        // Content type buttons animation - 0.3s delay + 0.3s duration = finishes at 0.6s
        withAnimation(.easeOut(duration: 0.3).delay(0.3)) {
            contentTypesVisible = true
        }
                    
        // Schedule haptic feedback for when step indicator animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.softImpactGenerator.impactOccurred()
        }

        // Step indicator animation - 0.5s delay + 0.5s duration = finishes at 1.0s
        withAnimation(.easeOut(duration: 0.5).delay(0.5)) {
            stepIndicatorVisible = true
        }
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
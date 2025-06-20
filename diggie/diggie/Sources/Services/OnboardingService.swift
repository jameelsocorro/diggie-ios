//
//  OnboardingService.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import Foundation

/// Service managing onboarding flow coordination and data persistence
@Observable
@MainActor
final class OnboardingService {
    
    // MARK: - Published Properties
    
    /// Current onboarding step (1-5)
    var currentStep: Int = 1
    
    /// Selected platforms from step 1
    var selectedPlatforms: Set<Platform> = []
    
    /// Selected posting frequency from step 2
    var postingFrequency: PostingFrequency?
    
    /// Selected content types from step 3
    var selectedContentTypes: Set<ContentType> = []
    
    /// Selected pain points from step 4 (max 2)
    var selectedPainPoints: Set<PainPoint> = []
    
    /// Whether onboarding has been completed
    var hasCompletedOnboarding: Bool = false
    
    // MARK: - Computed Properties
    
    /// Progress percentage (0.0 to 1.0)
    var progress: Double {
        Double(currentStep - 1) / 4.0
    }
    
    /// Check if current step is complete and can proceed
    var canProceedFromCurrentStep: Bool {
        switch currentStep {
        case 1: return !selectedPlatforms.isEmpty
        case 2: return postingFrequency != nil
        case 3: return !selectedContentTypes.isEmpty
        case 4: return !selectedPainPoints.isEmpty
        case 5: return true // Paywall screen can always proceed
        default: return false
        }
    }
    
    // MARK: - Navigation Methods
    
    /// Move to next step if current step is valid
    func nextStep() {
        guard canProceedFromCurrentStep && currentStep < 5 else { return }
        currentStep += 1
    }
    
    /// Move to previous step
    func previousStep() {
        guard currentStep > 1 else { return }
        currentStep -= 1
    }
    
    /// Complete onboarding and notify the app
    func completeOnboarding() {
        hasCompletedOnboarding = true
        NotificationCenter.default.post(name: .onboardingCompleted, object: nil)
    }
    
    // MARK: - Data Management Methods
    
    /// Update selected platforms
    /// - Parameter platforms: Set of selected platforms
    func updateSelectedPlatforms(_ platforms: Set<Platform>) {
        selectedPlatforms = platforms
    }
    
    /// Update posting frequency
    /// - Parameter frequency: Selected posting frequency
    func updatePostingFrequency(_ frequency: PostingFrequency?) {
        postingFrequency = frequency
    }
    
    /// Update selected content types
    /// - Parameter contentTypes: Set of selected content types
    func updateSelectedContentTypes(_ contentTypes: Set<ContentType>) {
        selectedContentTypes = contentTypes
    }
    
    /// Update selected pain points (max 2)
    /// - Parameter painPoints: Set of selected pain points
    func updateSelectedPainPoints(_ painPoints: Set<PainPoint>) {
        // Ensure maximum of 2 pain points
        selectedPainPoints = Set(painPoints.prefix(2))
    }
    
    // MARK: - Reset Method
    
    /// Reset all onboarding data
    func reset() {
        currentStep = 1
        selectedPlatforms.removeAll()
        postingFrequency = nil
        selectedContentTypes.removeAll()
        selectedPainPoints.removeAll()
        hasCompletedOnboarding = false
    }
}

// MARK: - Notification Names
extension Notification.Name {
    static let onboardingCompleted = Notification.Name("onboardingCompleted")
}
//
//  OSPreferenceScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 22/6/25.
//

import Foundation
import SwiftUI

/// ViewModel for OS Preference screen (Onboarding Step 5)
@Observable
@MainActor
final class OSPreferenceScreenViewModel {
    
    // MARK: - Dependencies
    
    private let onboardingService: OnboardingService
    
    // MARK: - Haptic Feedback
    
    /// Haptic feedback generators (prepared for optimal performance)
    private let softImpactGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    // MARK: - Published Properties
    
    /// Currently selected OS preference
    var selectedOSPreference: OSPreference?
    
    /// Whether the header is visible
    var headerVisible: Bool = false
    
    /// Whether the OS options are visible
    var osOptionsVisible: Bool = false
    
    /// Whether the step indicator is visible
    var stepIndicatorVisible: Bool = false
    
    /// Whether this screen is currently active
    var isActive: Bool = false

    // MARK: - Computed Properties
    
    /// Available OS preference options
    var availableOSOptions: [OSPreference] {
        OSPreference.allCases
    }
    
    /// Progress for this step (100%)
    var progress: Double {
        1.0
    }
    
    /// Step indicator text
    var stepIndicator: String {
        "Step 5 of 5"
    }
    
    // MARK: - Initialization
    
    /// Initialize with onboarding service dependency
    /// - Parameters:
    ///   - onboardingService: Service managing onboarding flow
    init(onboardingService: OnboardingService) {
        self.onboardingService = onboardingService
        loadExistingData()
        softImpactGenerator.prepare()
    }
    
    // MARK: - Public Methods
    
    /// Select an OS preference
    /// - Parameter osPreference: OS preference to select
    func selectOSPreference(_ osPreference: OSPreference) {
        selectedOSPreference = osPreference
        syncWithService()
        
        // Automatically complete onboarding after selection
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                self.finishOnboarding()
            }
        }
    }
    
    /// Check if an OS preference is selected
    /// - Parameter osPreference: OS preference to check
    /// - Returns: Whether the OS preference is selected
    func isOSPreferenceSelected(_ osPreference: OSPreference) -> Bool {
        selectedOSPreference == osPreference
    }
    
    /// Finish onboarding flow
    func finishOnboarding() {
        onboardingService.completeOnboarding()
    }

    /// Called when screen appears (but may not be active yet)
    func onScreenAppeared() {
        // Just mark that screen has appeared, don't start animations yet
    }
    
    /// Start the entrance animations with staggered timing
    func startAnimations() {
        guard isActive else { return }
        
        withAnimation(.easeOut(duration: 0.2)) {
            headerVisible = true
        }
      
        // Schedule haptic feedback for when OS option buttons animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.softImpactGenerator.impactOccurred()
        }

        // OS options animation - 0.3s delay + 0.3s duration = finishes at 0.6s
        withAnimation(.easeOut(duration: 0.3).delay(0.3)) {
            osOptionsVisible = true
        }
                    
        // Schedule haptic feedback for when step indicator animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.softImpactGenerator.impactOccurred()
        }

        // Step indicator animation - 0.3s delay + 0.5s duration = finishes at 0.8s
        withAnimation(.easeOut(duration: 0.5).delay(0.3)) {
            stepIndicatorVisible = true
        }
    }
    
    /// Update active state from parent flow
    func updateActiveState(_ isActive: Bool) {
        self.isActive = isActive
    }
    
    // MARK: - Private Methods
    
    /// Load existing data from service
    private func loadExistingData() {
        selectedOSPreference = onboardingService.osPreference
    }
    
    /// Sync current selection with the onboarding service
    private func syncWithService() {
        onboardingService.updateOSPreference(selectedOSPreference)
    }
}
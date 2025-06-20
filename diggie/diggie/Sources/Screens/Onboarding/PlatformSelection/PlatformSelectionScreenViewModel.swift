//
//  PlatformSelectionScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import Foundation
import UIKit
import SwiftUI

/// ViewModel for Platform Selection screen (Onboarding Step 1)
@Observable
@MainActor
final class PlatformSelectionScreenViewModel {
    
    // MARK: - Dependencies
    
    private let onboardingService: OnboardingService
    private let navigateForward: (() -> Void)?
    
    // MARK: - Haptic Feedback
    
    /// Haptic feedback generators (prepared for optimal performance)
    private let softImpactGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    // MARK: - Published Properties
    
    /// Currently selected platforms
    var selectedPlatforms: Set<Platform> = []
    
    /// Whether the continue button should be enabled
    var canContinue: Bool = false
    
    // MARK: - Animation Properties
    
    /// Controls header section animation visibility
    var headerVisible: Bool = false
    
    /// Controls platform buttons section animation visibility
    var platformsVisible: Bool = false
    
    /// Controls continue button section animation visibility
    var continueButtonVisible: Bool = false
    
    /// Whether this screen is currently active
    var isActive: Bool = false
    
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
    /// - Parameters:
    ///   - onboardingService: Service managing onboarding flow
    ///   - navigateForward: Optional callback for forward navigation with proper animation
    init(onboardingService: OnboardingService, navigateForward: (() -> Void)? = nil) {
        self.onboardingService = onboardingService
        self.navigateForward = navigateForward
        
        // Prepare haptic feedback generators for optimal performance
        softImpactGenerator.prepare()        
        
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
        softImpactGenerator.impactOccurred()
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
        if let navigateForward = navigateForward {
            navigateForward()
        } else {
            onboardingService.nextStep()
        }
    }
    
    /// Start the entrance animations with staggered timing
    func startAnimations() {
        guard isActive else { return }
        
        withAnimation(.easeOut(duration: 0.2)) {
            headerVisible = true
        }
      
        // Schedule haptic feedback for when platform buttons animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.softImpactGenerator.impactOccurred()
        }

        // Platform buttons animation - 0.3s delay + 0.3s duration = finishes at 0.6s
        withAnimation(.easeOut(duration: 0.3).delay(0.3)) {
            platformsVisible = true
        }
                    
        // Schedule haptic feedback for when continue button animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.softImpactGenerator.impactOccurred()
        }

        // Continue button animation - 0.3s delay + 0.5s duration = finishes at 0.8s
        withAnimation(.easeOut(duration: 0.5).delay(0.3)) {
            continueButtonVisible = true
        }
    }
    
    /// Update active state from parent flow
    func updateActiveState(_ isActive: Bool) {
        self.isActive = isActive
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

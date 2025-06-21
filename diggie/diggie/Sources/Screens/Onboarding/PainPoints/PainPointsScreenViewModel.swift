//
//  PainPointsScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import Foundation
import SwiftUI

/// ViewModel for Pain Points screen (Onboarding Step 4)
@Observable
@MainActor
final class PainPointsScreenViewModel {
    
    // MARK: - Dependencies
    
    private let onboardingService: OnboardingService
    private let navigateForward: (() -> Void)?
    
    // MARK: - Haptic Feedback
    
    /// Haptic feedback generators (prepared for optimal performance)
    private let softImpactGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    // MARK: - Published Properties
    
    /// Currently selected pain points (max 2)
    var selectedPainPoints: Set<PainPoint> = []
    
    /// Whether the continue button should be enabled
    var canContinue: Bool = false
    
    /// Whether this screen is currently active for animations
    var isActive: Bool = false
    
    /// Whether the header is visible
    var headerVisible: Bool = false
    
    /// Whether the pain point options are visible
    var painPointsVisible: Bool = false
    
    /// Whether the guidance text is visible
    var guidanceVisible: Bool = false
    
    /// Whether the step indicator is visible
    var stepIndicatorVisible: Bool = false
    
    // MARK: - Computed Properties
    
    /// Available pain point options
    var availablePainPoints: [PainPoint] {
        PainPoint.allCases
    }
    
    /// Progress for this step (80%)
    var progress: Double {
        0.8
    }
    
    /// Step indicator text
    var stepIndicator: String {
        "Step 4 of 5"
    }
    
    /// Selection guidance text
    var selectionGuidance: String {
        switch selectedPainPoints.count {
        case 0:
            return "Select up to 2 challenges"
        case 1:
            return "Select 1 more challenge (optional)"
        case 2:
            return "Great! You've selected 2 challenges"
        default:
            return ""
        }
    }
    
    /// Whether selection guidance should be shown
    var shouldShowGuidance: Bool {
        selectedPainPoints.count < 2
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
    
    /// Toggle pain point selection (max 2)
    /// - Parameter painPoint: Pain point to toggle
    func togglePainPoint(_ painPoint: PainPoint) {
        if selectedPainPoints.contains(painPoint) {
            selectedPainPoints.remove(painPoint)
        } else if selectedPainPoints.count < 2 {
            selectedPainPoints.insert(painPoint)
        }
        softImpactGenerator.impactOccurred()
        updateContinueState()
        syncWithService()
    }
    
    /// Check if a pain point is selected
    /// - Parameter painPoint: Pain point to check
    /// - Returns: Whether the pain point is selected
    func isPainPointSelected(_ painPoint: PainPoint) -> Bool {
        selectedPainPoints.contains(painPoint)
    }
    
    /// Check if a pain point should be disabled (when 2 are already selected)
    /// - Parameter painPoint: Pain point to check
    /// - Returns: Whether the pain point should be disabled
    func isPainPointDisabled(_ painPoint: PainPoint) -> Bool {
        !selectedPainPoints.contains(painPoint) && selectedPainPoints.count >= 2
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
      
        // Schedule haptic feedback for when pain point buttons animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.softImpactGenerator.impactOccurred()
        }

        // Pain point buttons animation - 0.3s delay + 0.3s duration = finishes at 0.6s
        withAnimation(.easeOut(duration: 0.3).delay(0.3)) {
            painPointsVisible = true
        }
        
        // Guidance text animation - 0.4s delay + 0.2s duration = finishes at 0.6s
        withAnimation(.easeOut(duration: 0.2).delay(0.4)) {
            guidanceVisible = true
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
        selectedPainPoints = onboardingService.selectedPainPoints
        updateContinueState()
    }
    
    /// Update continue button state based on selections
    private func updateContinueState() {
        canContinue = !selectedPainPoints.isEmpty
    }
    
    /// Sync current selections with the onboarding service
    private func syncWithService() {
        onboardingService.updateSelectedPainPoints(selectedPainPoints)
    }
}
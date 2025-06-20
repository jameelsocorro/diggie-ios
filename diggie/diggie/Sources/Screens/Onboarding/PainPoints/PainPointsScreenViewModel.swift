//
//  PainPointsScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import Foundation

/// ViewModel for Pain Points screen (Onboarding Step 4)
@Observable
@MainActor
final class PainPointsScreenViewModel {
    
    // MARK: - Dependencies
    
    private let onboardingService: OnboardingService
    private let navigateForward: (() -> Void)?
    
    // MARK: - Published Properties
    
    /// Currently selected pain points (max 2)
    var selectedPainPoints: Set<PainPoint> = []
    
    /// Whether the continue button should be enabled
    var canContinue: Bool = false
    
    /// Whether this screen is currently active for animations
    var isActive: Bool = false
    
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
        if selectedPainPoints.count < 2 {
            return "Select up to 2 challenges"
        } else {
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
        // Animation implementation will be added here when needed
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
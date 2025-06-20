//
//  PricingScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import Foundation

/// ViewModel for Pricing & Value Proposition screen (Onboarding Step 5)
@Observable
@MainActor
final class PricingScreenViewModel {
    
    // MARK: - Dependencies
    
    private let onboardingService: OnboardingService
    
    // MARK: - Published Properties
    
    /// Whether a purchase is in progress
    var isPurchaseInProgress: Bool = false
    
    /// Whether this screen is currently active for animations
    var isActive: Bool = false
    
    // MARK: - Computed Properties
    
    /// Progress for this step (100%)
    var progress: Double {
        1.0
    }
    
    /// Step indicator text
    var stepIndicator: String {
        "Step 5 of 5"
    }
    
    /// Personalized title based on selected platforms
    var personalizedTitle: String {
        let platforms = Array(onboardingService.selectedPlatforms).prefix(2).map(\.displayName)
        if platforms.count >= 2 {
            return "Great! You use \(platforms[0]) and \(platforms[1])+"
        } else if platforms.count == 1 {
            return "Great! You use \(platforms[0])"
        } else {
            return "Perfect! Let's get you started"
        }
    }
    
    /// Personalized benefits based on onboarding selections
    var personalizedBenefits: [String] {
        var benefits: [String] = []
        
        // Add platform-specific benefits
        let selectedPlatforms = onboardingService.selectedPlatforms
        if selectedPlatforms.contains(.x) {
            benefits.append("Post to X (Twitter)")
        }
        if selectedPlatforms.contains(.linkedin) {
            benefits.append("LinkedIn integration")
        }
        if selectedPlatforms.contains(.instagram) {
            benefits.append("Instagram posting")
        }
        
        // Add content-type specific benefits
        if onboardingService.selectedContentTypes.contains(.imageContent) {
            benefits.append("Image optimization for each platform")
        }
        if onboardingService.selectedContentTypes.contains(.videoContent) {
            benefits.append("Video format conversion")
        }
        
        // Add pain-point specific benefits
        if onboardingService.selectedPainPoints.contains(.timeManagement) {
            benefits.append("Bulk scheduling & automation")
        }
        if onboardingService.selectedPainPoints.contains(.contentIdeas) {
            benefits.append("AI content suggestions")
        }
        if onboardingService.selectedPainPoints.contains(.writingQuality) {
            benefits.append("AI writing assistance")
        }
        
        // Default benefits if none specific
        if benefits.isEmpty {
            benefits = [
                "All platform integrations",
                "Advanced scheduling",
                "Analytics dashboard",
                "Priority support"
            ]
        }
        
        return Array(benefits.prefix(4))
    }
    
    // MARK: - Initialization
    
    /// Initialize with onboarding service dependency
    /// - Parameter onboardingService: Service managing onboarding flow
    init(onboardingService: OnboardingService) {
        self.onboardingService = onboardingService
    }
    
    // MARK: - Public Methods
    
    /// Handle early bird subscription selection
    func selectEarlyBird() {
        isPurchaseInProgress = true
        
        // TODO: Integrate with RevenueCat for subscription purchase
        // For now, simulate purchase completion
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isPurchaseInProgress = false
            self.completeOnboarding()
        }
    }
    
    /// Handle free tier selection
    func selectFreeTier() {
        completeOnboarding()
    }
    
    /// Handle "maybe later" selection
    func selectMaybeLater() {
        completeOnboarding()
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
    
    /// Complete onboarding process
    private func completeOnboarding() {
        onboardingService.completeOnboarding()
    }
}
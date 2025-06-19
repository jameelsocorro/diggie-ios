//
//  WelcomeScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 19/6/25.
//

import SwiftUI
import Observation

/// View model for the Welcome Screen
@Observable
@MainActor
final class WelcomeScreenViewModel {
    
    /// Animation states for different elements
    var logoVisible = false
    var taglineVisible = false
    var ctaButtonVisible = false
    
    /// Callback to handle CTA button tap
    private let onCTATap: () -> Void
    
    /// Pre-prepared haptic feedback generators for optimal performance
    private let softFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    private let mediumFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    /// Initialize the welcome screen view model
    /// - Parameter onCTATap: Callback to execute when CTA button is tapped
    init(onCTATap: @escaping () -> Void) {
        self.onCTATap = onCTATap
        
        // Prepare feedback generators for optimal performance
        softFeedbackGenerator.prepare()
        mediumFeedbackGenerator.prepare()
    }
    
    /// Start the welcome screen animations with haptic feedback triggered on start
    func startAnimations() {
        // Schedule haptic feedback for when logo animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.softFeedbackGenerator.impactOccurred()
        }
        
        // Animate logo first
        withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
            logoVisible = true
        }
        
        // Schedule haptic feedback for when tagline animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.softFeedbackGenerator.impactOccurred()
        }
        
        // Animate tagline second
        withAnimation(.easeOut(duration: 0.8).delay(0.8)) {
            taglineVisible = true
        }
        
        // Schedule haptic feedback for when CTA button animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            self.mediumFeedbackGenerator.impactOccurred()
        }
        
        // Animate CTA button last
        withAnimation(.easeOut(duration: 0.6).delay(1.3)) {
            ctaButtonVisible = true
        }
    }
    
    /// Handle the CTA button tap with haptic feedback
    func handleCTATap() {
        // Trigger button tap haptic feedback using pre-prepared generator
        mediumFeedbackGenerator.impactOccurred()
        
        // Execute the callback
        onCTATap()
    }
}

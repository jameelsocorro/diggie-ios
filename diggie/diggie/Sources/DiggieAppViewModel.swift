//
//  DiggieAppViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 19/6/25.
//

import SwiftUI
import Observation

/// Main app view model managing global app state and navigation
@Observable
@MainActor
final class DiggieAppViewModel {
    
    /// Current screen being displayed
    var currentScreen: AppScreen = .welcome
    
    /// Navigation path for deep linking and programmatic navigation
    var navigationPath = NavigationPath()
    
    /// Initialize the app view model
    init() {
        // Set initial screen to welcome for new users
        currentScreen = .welcome
    }
    
    /// Navigate to a specific screen
    /// - Parameter screen: The screen to navigate to
    func navigateToScreen(_ screen: AppScreen) {
        currentScreen = screen
    }
    
    /// Handle welcome screen CTA button tap
    func handleWelcomeCTATap() {
        navigateToScreen(.onboarding)
    }
}

/// Available app screens
enum AppScreen: String, CaseIterable {
    case welcome = "welcome"
    case onboarding = "onboarding"
    case accountSetup = "accountSetup"
    case main = "main"
    
    var title: String {
        switch self {
        case .welcome:
            return "Welcome"
        case .onboarding:
            return "Onboarding"
        case .accountSetup:
            return "Account Setup"
        case .main:
            return "Main"
        }
    }
}
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
    
    /// Callback to handle CTA button tap
    private let onCTATap: () -> Void
    
    /// Initialize the welcome screen view model
    /// - Parameter onCTATap: Callback to execute when CTA button is tapped
    init(onCTATap: @escaping () -> Void) {
        self.onCTATap = onCTATap
    }
    
    /// Handle the CTA button tap
    func handleCTATap() {
        // Execute the callback
        onCTATap()
    }
}
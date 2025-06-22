//
//  InitialSetupScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 22/6/25.
//

import Foundation
import SwiftUI
import Observation

/// View model for the initial account setup screen
@Observable
@MainActor
final class InitialSetupScreenViewModel {
    
    // MARK: - Dependencies
    private let accountService: AccountService
    private let onSkip: () -> Void
    private let onContinue: () -> Void
    
    // MARK: - Animation State
    var headerVisible = false
    var platformsVisible = false
    var actionsVisible = false
    
    // MARK: - Connection State
    private var connectingPlatforms: Set<SocialPlatform> = []
    
    // MARK: - Computed Properties
    var availablePlatforms: [SocialPlatform] {
        accountService.availablePlatforms
    }
    
    var hasConnectedAccounts: Bool {
        accountService.hasAnyConnectedAccounts
    }
    
    // MARK: - Initialization
    init(
        accountService: AccountService,
        onSkip: @escaping () -> Void,
        onContinue: @escaping () -> Void
    ) {
        self.accountService = accountService
        self.onSkip = onSkip
        self.onContinue = onContinue
    }
    
    // MARK: - Animation Methods
    func startAnimations() {
        withAnimation(.easeOut(duration: 0.6)) {
            headerVisible = true
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.2)) {
            platformsVisible = true
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.4)) {
            actionsVisible = true
        }
    }
    
    // MARK: - Connection Methods
    func isConnecting(_ platform: SocialPlatform) -> Bool {
        return connectingPlatforms.contains(platform)
    }
    
    func connectPlatform(_ platform: SocialPlatform) async {
        connectingPlatforms.insert(platform)
        
        await accountService.connectAccount(for: platform)
        
        connectingPlatforms.remove(platform)
    }
    
    // MARK: - Navigation Methods
    func skipAccountSetup() {
        onSkip()
    }
    
    func proceedToNextStep() {
        onContinue()
    }
}
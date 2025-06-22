//
//  ConnectedAccountsScreenViewModel.swift
//  Diggie
//
//  Created by Jameel Socorro on 22/6/25.
//

import Foundation
import SwiftUI
import Observation

/// View model for the connected accounts screen
@Observable
@MainActor
final class ConnectedAccountsScreenViewModel {
    
    // MARK: - Dependencies
    private let accountService: AccountService
    private let onContinue: () -> Void
    
    // MARK: - Animation State
    var headerVisible = false
    var accountsVisible = false
    var availablePlatformsVisible = false
    var actionsVisible = false
    
    // MARK: - UI State
    var showingRemoveAllAlert = false
    
    // MARK: - Connection State
    private var connectingPlatforms: Set<SocialPlatform> = []
    
    // MARK: - Computed Properties
    var connectedAccounts: [ConnectedAccount] {
        accountService.connectedAccounts.filter { $0.isConnected }
    }
    
    var availablePlatforms: [SocialPlatform] {
        accountService.getAvailablePlatforms()
    }
    
    var hasAvailablePlatforms: Bool {
        !availablePlatforms.isEmpty
    }
    
    // MARK: - Initialization
    init(
        accountService: AccountService,
        onContinue: @escaping () -> Void
    ) {
        self.accountService = accountService
        self.onContinue = onContinue
    }
    
    // MARK: - Animation Methods
    func startAnimations() {
        withAnimation(.easeOut(duration: 0.6)) {
            headerVisible = true
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.2)) {
            accountsVisible = true
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.3)) {
            availablePlatformsVisible = true
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.4)) {
            actionsVisible = true
        }
    }
    
    // MARK: - Account Management Methods
    func disconnectAccount(_ account: ConnectedAccount) {
        accountService.disconnectAccount(account)
    }
    
    func showRemoveAllAccountsAlert() {
        showingRemoveAllAlert = true
    }
    
    func removeAllAccounts() {
        accountService.removeAllAccounts()
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
    func proceedToNextStep() {
        onContinue()
    }
}
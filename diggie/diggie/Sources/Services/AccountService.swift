//
//  AccountService.swift
//  Diggie
//
//  Created by Jameel Socorro on 22/6/25.
//

import Foundation
import Observation

/// Service for managing connected social media accounts
@Observable
@MainActor
final class AccountService {
    
    /// List of connected accounts
    private(set) var connectedAccounts: [ConnectedAccount] = []
    
    /// Available platforms for connection
    let availablePlatforms: [SocialPlatform] = SocialPlatform.allCases
    
    /// Initialize the account service
    init() {
        loadConnectedAccounts()
    }
    
    /// Load connected accounts from storage
    private func loadConnectedAccounts() {
        // TODO: Implement proper data persistence
        // For now, initialize with empty array
        connectedAccounts = []
    }
    
    /// Save connected accounts to storage
    private func saveConnectedAccounts() {
        // TODO: Implement proper data persistence
        // For now, just keep in memory
    }
    
    /// Get connected accounts for a specific platform
    /// - Parameter platform: The platform to filter by
    /// - Returns: Array of connected accounts for the platform
    func getConnectedAccounts(for platform: SocialPlatform) -> [ConnectedAccount] {
        return connectedAccounts.filter { $0.platform == platform }
    }
    
    /// Check if a platform has any connected accounts
    /// - Parameter platform: The platform to check
    /// - Returns: True if platform has connected accounts
    func hasConnectedAccount(for platform: SocialPlatform) -> Bool {
        return connectedAccounts.contains { $0.platform == platform && $0.isConnected }
    }
    
    /// Get all platforms that have connected accounts
    /// - Returns: Array of platforms with connected accounts
    func getConnectedPlatforms() -> [SocialPlatform] {
        return Array(Set(connectedAccounts.compactMap { $0.isConnected ? $0.platform : nil }))
    }
    
    /// Connect a new account (mocked implementation)
    /// - Parameter platform: The platform to connect
    func connectAccount(for platform: SocialPlatform) async {
        // Mock OAuth flow - in real implementation this would handle OAuth
        let mockAccount = ConnectedAccount(
            platform: platform,
            username: "user@\(platform.rawValue).com",
            displayName: "John Doe",
            status: .connecting
        )
        
        connectedAccounts.append(mockAccount)
        saveConnectedAccounts()
        
        // Simulate async OAuth process
        try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
        
        // Mock successful connection
        mockAccount.updateStatus(.connected)
        mockAccount.accessToken = "mock_access_token_\(UUID().uuidString)"
        
        saveConnectedAccounts()
    }
    
    /// Disconnect an account
    /// - Parameter account: The account to disconnect
    func disconnectAccount(_ account: ConnectedAccount) {
        if let index = connectedAccounts.firstIndex(where: { $0.id == account.id }) {
            connectedAccounts.remove(at: index)
            saveConnectedAccounts()
        }
    }
    
    /// Remove all connected accounts
    func removeAllAccounts() {
        connectedAccounts.removeAll()
        saveConnectedAccounts()
    }
    
    /// Get platforms that are available for connection (not already connected)
    /// - Returns: Array of platforms available for connection
    func getAvailablePlatforms() -> [SocialPlatform] {
        return availablePlatforms.filter { platform in
            !hasConnectedAccount(for: platform)
        }
    }
    
    /// Check if user can proceed without connecting accounts
    /// - Returns: True if user has at least one connected account or can skip
    var canProceedWithoutAccounts: Bool {
        return true // Always allow skip for now
    }
    
    /// Check if user has any connected accounts
    var hasAnyConnectedAccounts: Bool {
        return !connectedAccounts.isEmpty && connectedAccounts.contains { $0.isConnected }
    }
    
    /// Add mock accounts for testing/preview purposes
    func addMockAccounts(_ accounts: [ConnectedAccount]) {
        connectedAccounts.append(contentsOf: accounts)
    }
}
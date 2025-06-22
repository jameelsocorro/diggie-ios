//
//  AccountModels.swift
//  Diggie
//
//  Created by Jameel Socorro on 22/6/25.
//

import Foundation

/// Social media platforms supported for account connections
enum SocialPlatform: String, CaseIterable, Identifiable {
    case threads = "threads"
    case bluesky = "bluesky"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .threads: return "Threads"
        case .bluesky: return "Bluesky"
        }
    }
    
    var iconName: String {
        switch self {
        case .threads: return "Threads"
        case .bluesky: return "Bluesky"
        }
    }
    
    var characterLimit: Int {
        switch self {
        case .threads: return 500
        case .bluesky: return 280
        }
    }
}

/// Account connection status
enum AccountConnectionStatus: String, CaseIterable {
    case disconnected = "disconnected"
    case connecting = "connecting"
    case connected = "connected"
    case failed = "failed"
    
    var displayName: String {
        switch self {
        case .disconnected: return "Not Connected"
        case .connecting: return "Connecting..."
        case .connected: return "Connected"
        case .failed: return "Connection Failed"
        }
    }
}

/// Connected social media account model
@Observable
final class ConnectedAccount: Identifiable {
    let id = UUID()
    let platform: SocialPlatform
    var username: String
    var displayName: String
    var profileImageURL: String?
    var status: AccountConnectionStatus
    var accessToken: String?
    var refreshToken: String?
    var connectedAt: Date
    
    init(
        platform: SocialPlatform,
        username: String,
        displayName: String,
        profileImageURL: String? = nil,
        status: AccountConnectionStatus = .disconnected,
        accessToken: String? = nil,
        refreshToken: String? = nil,
        connectedAt: Date = Date()
    ) {
        self.platform = platform
        self.username = username
        self.displayName = displayName
        self.profileImageURL = profileImageURL
        self.status = status
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.connectedAt = connectedAt
    }
    
    /// Update account connection status
    func updateStatus(_ newStatus: AccountConnectionStatus) {
        status = newStatus
    }
    
    /// Check if account is connected and ready to post
    var isConnected: Bool {
        status == .connected && accessToken != nil
    }
}
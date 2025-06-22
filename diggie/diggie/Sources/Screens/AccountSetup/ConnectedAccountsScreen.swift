//
//  ConnectedAccountsScreen.swift
//  Diggie
//
//  Created by Jameel Socorro on 22/6/25.
//

import SwiftUI

/// Screen showing connected accounts with management options
struct ConnectedAccountsScreen: View {
    
    let viewModel: ConnectedAccountsScreenViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer().frame(height: 24)
            
            // Header
            VStack(alignment: .leading, spacing: 12) {
                Text("Setup channels")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Manage your connected social media accounts.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .opacity(viewModel.headerVisible ? 1 : 0)
            
            Spacer().frame(height: 24)
            
            // Connected accounts
            VStack(spacing: 16) {
                ForEach(viewModel.connectedAccounts) { account in
                    ConnectedAccountRow(
                        account: account,
                        onDisconnect: {
                            viewModel.disconnectAccount(account)
                        }
                    )
                }
            }
            .padding(.horizontal)
            .opacity(viewModel.accountsVisible ? 1 : 0)
            .offset(y: viewModel.accountsVisible ? 0 : 50)
            
            // Add more accounts section
            if viewModel.hasAvailablePlatforms {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Add more accounts")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        ForEach(viewModel.availablePlatforms) { platform in
                            PlatformConnectionRow(
                                platform: platform,
                                isConnecting: viewModel.isConnecting(platform),
                                onConnect: {
                                    Task {
                                        await viewModel.connectPlatform(platform)
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                .opacity(viewModel.availablePlatformsVisible ? 1 : 0)
                .offset(y: viewModel.availablePlatformsVisible ? 0 : 30)
            }
            
            Spacer()
            
            // Continue button
            VStack(spacing: 16) {
                PrimaryButton(
                    "Continue",
                    isVisible: true
                ) {
                    viewModel.proceedToNextStep()
                }
                .padding(.horizontal)
                
                // Account management
                Button("Remove All Accounts") {
                    viewModel.showRemoveAllAccountsAlert()
                }
                .foregroundColor(.red)
                .font(.subheadline)
            }
            .padding(.bottom)
            .opacity(viewModel.actionsVisible ? 1 : 0)
            .offset(y: viewModel.actionsVisible ? 0 : 30)
        }
        .onAppear {
            viewModel.startAnimations()
        }
        .alert(
            "Remove All Accounts",
            isPresented: Binding(
                get: { viewModel.showingRemoveAllAlert },
                set: { viewModel.showingRemoveAllAlert = $0 }
            )
        ) {
            Button("Cancel", role: .cancel) { }
            Button("Remove All", role: .destructive) {
                viewModel.removeAllAccounts()
            }
        } message: {
            Text("This will disconnect all your social media accounts. You can reconnect them later.")
        }
    }
}

/// Row for displaying connected account
struct ConnectedAccountRow: View {
    let account: ConnectedAccount
    let onDisconnect: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Profile image placeholder
            Circle()
                .fill(Color.blue)
                .frame(width: 40, height: 40)
                .overlay(
                    Text(String(account.displayName.prefix(1)))
                        .font(.headline)
                        .foregroundColor(.white)
                )
            
            // Account info
            VStack(alignment: .leading, spacing: 2) {
                Text(account.displayName)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                HStack(spacing: 4) {
                    Image(account.platform.iconName)
                        .resizable()
                        .frame(width: 16, height: 16)
                    
                    Text(account.platform.displayName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Connection status
            HStack(spacing: 8) {
                if account.isConnected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title3)
                } else {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.orange)
                        .font(.title3)
                }
                
                // Disconnect button
                Button("Disconnect") {
                    onDisconnect()
                }
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    let accountService = AccountService()
    
    // Add some mock connected accounts
    let mockAccount1 = ConnectedAccount(
        platform: SocialPlatform.threads,
        username: "john.doe",
        displayName: "John Doe",
        status: AccountConnectionStatus.connected
    )
    
    let mockAccount2 = ConnectedAccount(
        platform: SocialPlatform.bluesky,
        username: "jane.smith",
        displayName: "Jane Smith",
        status: AccountConnectionStatus.connected
    )
    
    accountService.addMockAccounts([mockAccount1, mockAccount2])
    
    let viewModel = ConnectedAccountsScreenViewModel(accountService: accountService) {
        print("Continue tapped")
    }
    
    return ConnectedAccountsScreen(viewModel: viewModel)
        .background(Color.black)
        .onAppear {
            viewModel.startAnimations()
        }
}
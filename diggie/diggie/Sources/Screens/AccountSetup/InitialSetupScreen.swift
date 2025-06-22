//
//  InitialSetupScreen.swift
//  Diggie
//
//  Created by Jameel Socorro on 22/6/25.
//

import SwiftUI

/// Initial account setup screen showing available platforms
struct InitialSetupScreen: View {
    
    let viewModel: InitialSetupScreenViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer().frame(height: 24)
            
            // Header
            VStack(alignment: .leading, spacing: 12) {
                Text("Setup channels")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Connect your social media accounts to start posting.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .opacity(viewModel.headerVisible ? 1 : 0)
            
            Spacer().frame(height: 24)
            
            // Available platforms
            VStack(spacing: 16) {
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
            .opacity(viewModel.platformsVisible ? 1 : 0)
            .offset(y: viewModel.platformsVisible ? 0 : 50)
            
            Spacer()
            
            // Action buttons
            VStack(spacing: 16) {
                if viewModel.hasConnectedAccounts {
                    PrimaryButton(
                        "Continue",
                        isVisible: true
                    ) {
                        viewModel.proceedToNextStep()
                    }
                    .padding(.horizontal)
                }
                
                Button("Skip for now") {
                    viewModel.skipAccountSetup()
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
            .padding(.bottom)
            .opacity(viewModel.actionsVisible ? 1 : 0)
            .offset(y: viewModel.actionsVisible ? 0 : 30)
        }
        .onAppear {
            viewModel.startAnimations()
        }
    }
}


#Preview {
    let accountService = AccountService()
    let viewModel = InitialSetupScreenViewModel(accountService: accountService) {
        print("Skip tapped")
    } onContinue: {
        print("Continue tapped")
    }
    
    viewModel.startAnimations()
    
    return InitialSetupScreen(viewModel: viewModel)
        .background(Color.black)
}
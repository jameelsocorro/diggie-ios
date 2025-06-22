//
//  DiggieApp.swift
//  Diggie
//
//  Created by Jameel Socorro on 18/6/25.
//

import SwiftUI

@main
struct DiggieApp: App {
    
    /// App-wide view model managing navigation and state
    @State private var appViewModel = DiggieAppViewModel()
    
    /// Account service for managing connected accounts
    @State private var accountService = AccountService()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appViewModel.navigationPath) {
                rootView
            }
            .environment(appViewModel)
            .environment(accountService)
        }
    }
    
    /// Root view based on current app state
    @ViewBuilder
    private var rootView: some View {
        switch appViewModel.currentScreen {
        case .welcome:
            WelcomeScreen(
                viewModel: WelcomeScreenViewModel {
                    appViewModel.handleWelcomeCTATap()
                }
            )
        case .onboarding:
            OnboardingFlowView()
        case .accountSetup:
            accountSetupView
        case .main:
            // TODO: Implement main app flow
            Text("Main App - Coming Soon")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
        }
    }
    
    /// Account setup view based on current state
    @ViewBuilder
    private var accountSetupView: some View {
        if accountService.hasAnyConnectedAccounts {
            ConnectedAccountsScreen(
                viewModel: ConnectedAccountsScreenViewModel(
                    accountService: accountService
                ) {
                    appViewModel.navigateToScreen(.main)
                }
            )
        } else {
            InitialSetupScreen(
                viewModel: InitialSetupScreenViewModel(
                    accountService: accountService,
                    onSkip: {
                        appViewModel.navigateToScreen(.main)
                    },
                    onContinue: {
                        appViewModel.navigateToScreen(.main)
                    }
                )
            )
        }
    }
}

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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appViewModel.navigationPath) {
                rootView
            }
            .environment(appViewModel)
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
        case .main:
            // TODO: Implement main app flow
            Text("Main App - Coming Soon")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
        }
    }
}

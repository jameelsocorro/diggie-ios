//
//  OSPreferenceScreen.swift
//  Diggie
//
//  Created by Jameel Socorro on 22/6/25.
//

import SwiftUI

/// Onboarding Screen 5: OS Support Priority
struct OSPreferenceScreen: View {
    
    let viewModel: OSPreferenceScreenViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer().frame(height: 24)
            
            // Header
            VStack(alignment: .leading, spacing: 12) {
                Text("Which OS should we support next?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: 300, alignment: .leading)
                
                Text("This helps us prioritize our development roadmap.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: 350, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .opacity(viewModel.headerVisible ? 1 : 0)
            
            Spacer().frame(height: 24)
            
            // OS preference options
            VStack(spacing: 16) {
                ForEach(viewModel.availableOSOptions) { osOption in
                    ToggleButton(
                        title: osOption.displayName,
                        isSelected: viewModel.isOSPreferenceSelected(osOption),
                        configuration: .fullWidth
                    ) {
                        viewModel.selectOSPreference(osOption)
                    }
                }
            }
            .padding(.horizontal)
            .opacity(viewModel.osOptionsVisible ? 1 : 0)
            .offset(y: viewModel.osOptionsVisible ? 0 : 50)            
            
            Spacer()
            
            // Step indicator
            Text(viewModel.stepIndicator)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom)
                .opacity(viewModel.stepIndicatorVisible ? 1 : 0)
                .offset(y: viewModel.stepIndicatorVisible ? 0 : 30)
                .scaleEffect(viewModel.stepIndicatorVisible ? 1 : 0.9)
        }
        .onAppear {
            if viewModel.isActive {
                viewModel.startAnimations()
            }
        }
        .onChange(of: viewModel.isActive) { _, isActive in
            if isActive {
                viewModel.startAnimations()
            }
        }
    }
}

#Preview {
    let service = OnboardingService()
    let viewModel = OSPreferenceScreenViewModel(onboardingService: service)
    return OSPreferenceScreen(viewModel: viewModel)
}
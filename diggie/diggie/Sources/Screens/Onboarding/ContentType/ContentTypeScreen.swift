//
//  ContentTypeScreen.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import SwiftUI

/// Onboarding Screen 3: Content Type Selection
struct ContentTypeScreen: View {
    
    let viewModel: ContentTypeScreenViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Header
            VStack(spacing: 12) {
                Text("What do you create?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("This helps me build the right tools for you.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Content type options
            VStack(spacing: 16) {
                ForEach(viewModel.availableContentTypes) { contentType in
                    ContentTypeButton(
                        contentType: contentType,
                        isSelected: viewModel.isContentTypeSelected(contentType)
                    ) {
                        viewModel.toggleContentType(contentType)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Continue button
            VStack(spacing: 16) {
                PrimaryButton(
                    "Continue",
                    isVisible: viewModel.canContinue
                ) {
                    withAnimation {
                        viewModel.continueToNextStep()
                    }
                }
                .padding(.horizontal)
                
                // Step indicator
                Text(viewModel.stepIndicator)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    let service = OnboardingService()
    let viewModel = ContentTypeScreenViewModel(onboardingService: service)
    return ContentTypeScreen(viewModel: viewModel)
}

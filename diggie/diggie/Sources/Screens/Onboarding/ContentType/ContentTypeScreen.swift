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
            Spacer().frame(height: 24)
            
            // Header
            VStack(alignment: .leading, spacing: 12) {
                Text("What do you create?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: 200, alignment: .leading)
                
                Text("This helps me build the right tools for you.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: 300, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .opacity(viewModel.headerVisible ? 1 : 0)

            
            Spacer().frame(height: 24)
            
            // Content type options
            VStack(spacing: 16) {
                ForEach(viewModel.availableContentTypes) { contentType in
                    ToggleButton(
                        title: contentType.displayName,
                        description: contentType.description,
                        isSelected: viewModel.isContentTypeSelected(contentType),
                        configuration: .fullWidth
                    ) {
                        viewModel.toggleContentType(contentType)
                    }
                }
            }
            .padding(.horizontal)
            .opacity(viewModel.contentTypesVisible ? 1 : 0)
            .offset(y: viewModel.contentTypesVisible ? 0 : 50)
            
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
    let viewModel = ContentTypeScreenViewModel(onboardingService: service)
    return ContentTypeScreen(viewModel: viewModel)
}

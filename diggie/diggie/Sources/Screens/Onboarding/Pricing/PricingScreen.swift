//
//  PricingScreen.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import SwiftUI

/// Onboarding Screen 5: Pricing & Value Proposition
struct PricingScreen: View {
    
    let viewModel: PricingScreenViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Personalized header based on onboarding data
            VStack(spacing: 12) {
                Text(viewModel.personalizedTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Perfect! Here's what I can offer you:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            // Current free offering
            VStack(spacing: 16) {
                VStack(spacing: 8) {
                    Text("🎉 Available Now (Free)")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("Threads and Bluesky posting")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.green.opacity(0.1))
                        .stroke(Color.green, lineWidth: 2)
                )
            }
            .padding(.horizontal)
            
            // Premium offering
            VStack(spacing: 16) {
                VStack(spacing: 12) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Diggie Pro")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Early Bird Special")
                                .font(.subheadline)
                                .foregroundColor(.orange)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("$7.99/month")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.accentColor)
                            
                            Text("forever (47% off)")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                    }
                    
                    Text("Regular price: $14.99/month")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .strikethrough()
                    
                    // Benefits based on user selections
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.personalizedBenefits, id: \.self) { benefit in
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text(benefit)
                                    .font(.subheadline)
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.accentColor.opacity(0.1))
                        .stroke(Color.accentColor, lineWidth: 2)
                )
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Action buttons
            VStack(spacing: 12) {
                // Early bird CTA
                PrimaryButton(title: "Join Early Bird - $7.99/month") {
                    viewModel.selectEarlyBird()
                }
                .padding(.horizontal)
                
                // Free tier CTA
                Button("Start Free") {
                    viewModel.selectFreeTier()
                }
                .font(.headline)
                .foregroundColor(.accentColor)
                
                // Maybe later
                Button("Maybe Later") {
                    viewModel.selectMaybeLater()
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                // Step indicator
                Text(viewModel.stepIndicator)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    let service = OnboardingService()
    service.selectedPlatforms = [.x, .threads, .linkedin]
    service.postingFrequency = .fewTimesWeek
    service.selectedContentTypes = [.textPosts, .imageContent]
    service.selectedPainPoints = [.timeManagement, .contentIdeas]
    service.currentStep = 5
    
    let viewModel = PricingScreenViewModel(onboardingService: service)
    return PricingScreen(viewModel: viewModel)
}
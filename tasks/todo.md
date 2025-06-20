# Onboarding ViewModels Update Plan

## Task: Update onboarding screen ViewModels to accept navigateForward callback

Based on the analysis of the current implementations, I need to update 4 ViewModels to match the pattern established in `PlatformSelectionScreenViewModel`.

## Current State Analysis

**PlatformSelectionScreenViewModel (✅ Already Updated):**
- Constructor: `init(onboardingService: OnboardingService, navigateForward: (() -> Void)? = nil)`
- Has private `navigateForward` property
- `continueToNextStep()` uses callback if available, falls back to service

**ViewModels to Update:**
1. **PostingFrequencyScreenViewModel** - Missing navigateForward pattern
2. **ContentTypeScreenViewModel** - Missing navigateForward pattern  
3. **PainPointsScreenViewModel** - Missing navigateForward pattern
4. **PricingScreenViewModel** - Missing navigateForward pattern (special case - has multiple completion methods)

## Todo Items

- [ ] Update PostingFrequencyScreenViewModel constructor and continueToNextStep method
- [ ] Update ContentTypeScreenViewModel constructor and continueToNextStep method
- [ ] Update PainPointsScreenViewModel constructor and continueToNextStep method
- [ ] Update PricingScreenViewModel constructor and completion methods (selectEarlyBird, selectFreeTier, selectMaybeLater)

## Implementation Details

For each ViewModel (except PricingScreenViewModel):
1. Add optional `navigateForward: (() -> Void)? = nil` parameter to constructor
2. Store as private property 
3. Update `continueToNextStep()` method to check for callback first, fallback to service

For PricingScreenViewModel:
1. Add optional `navigateForward: (() -> Void)? = nil` parameter to constructor
2. Store as private property
3. Update `completeOnboarding()` method to use callback if available, fallback to service

## Expected Changes Summary

Each updated ViewModel will:
- Accept an optional navigation callback in the constructor
- Use the callback for navigation when provided
- Maintain backward compatibility with existing code
- Follow the same pattern as PlatformSelectionScreenViewModel

## Review Section
(To be completed after implementation)
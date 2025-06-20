# Update Onboarding Screens with .onAppear Handlers

## Overview
Add `.onAppear` handlers to the remaining three onboarding screens to ensure animations trigger when the screen first appears if it's already active.

## Tasks

### ContentTypeScreen
- [ ] Add `.onAppear` handler before the existing `.onChange(of: viewModel.isActive)` handler
- [ ] Follow the pattern: check if `viewModel.isActive` and call `viewModel.startAnimations()`

### PainPointsScreen  
- [ ] Add `.onAppear` handler before the existing `.onChange(of: viewModel.isActive)` handler
- [ ] Follow the pattern: check if `viewModel.isActive` and call `viewModel.startAnimations()`

### PricingScreen
- [ ] Add `.onAppear` handler before the existing `.onChange(of: viewModel.isActive)` handler
- [ ] Follow the pattern: check if `viewModel.isActive` and call `viewModel.startAnimations()`

## Implementation Details
Each screen needs this exact pattern added:
```swift
.onAppear {
    if viewModel.isActive {
        viewModel.startAnimations()
    }
}
```

This should be placed before the existing `.onChange(of: viewModel.isActive)` handler to maintain consistency with other onboarding screens.

## Files to Modify
- `/Users/jameelsocorro/Documents/Github/diggie-ios/Diggie/Diggie/Sources/Screens/Onboarding/ContentType/ContentTypeScreen.swift`
- `/Users/jameelsocorro/Documents/Github/diggie-ios/Diggie/Diggie/Sources/Screens/Onboarding/PainPoints/PainPointsScreen.swift`
- `/Users/jameelsocorro/Documents/Github/diggie-ios/Diggie/Diggie/Sources/Screens/Onboarding/Pricing/PricingScreen.swift`
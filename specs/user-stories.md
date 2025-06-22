# Diggie MVP - User Stories & Actionable Steps

I recommend checking the @.cursorrules for guidelines

## Primary User Story

**As a content creator**, I want to write once and post to multiple social platforms instantly, so I can save time and reach my audience everywhere without switching between apps.

---

## User Journey Breakdown

### Epic 1: Welcome Experience

#### Welcome Screen (@specs/ui-mockups/welcome.png)

**User Story**: As a new user, I want to understand the value proposition and have a clear way to get started.

##### Actionable Steps:

1. Display Diggie logo (Image name is "Logo") with gradient background (consistent with launch)
2. Show tagline: "One post. Everywhere. Instantly."
3. Present prominent "Try it for free" CTA button
4. Ensure button tap leads to onboarding flow
5. Make value proposition immediately clear and compelling

##### Acceptance Criteria:

- [x] Branding is consistent with launch screen
- [x] Value proposition is clear and compelling
- [x] CTA button is prominent and easily tappable
- [x] Smooth transition to onboarding flow
- [x] Text is readable and well-positioned

---

### Epic 2: Smart Onboarding Flow

**User Story**: As a new user, I want to quickly set up my account and help the app understand my needs so it can provide a personalized experience.

#### Screen 1: Platform Selection (@specs/ui-mockups/onboarding-1.png)

**User Story**: As a content creator, I want to select which platforms I currently use so the app knows which integrations to prioritize.

##### Actionable Steps:

1. Display question: "Which platforms do you use?"
2. Show subtitle: "This would help me understand which platform integrations to prioritize."
3. Present platform options as selectable buttons:
   - X (Twitter)
   - Threads
   - Bluesky
   - Mastodon
   - LinkedIn
   - Youtube
   - Youtube Shorts
   - Instagram
   - Tiktok
   - Others
4. Allow multiple selections (checkbox behavior)
5. Show "Continue" button at bottom
6. Display progress indicator at top

##### Acceptance Criteria:

- [x] All 5 target platforms are displayed as options
- [x] Multiple selection is supported
- [x] Visual feedback on selection (button state change)
- [x] Progress bar shows 20% completion
- [x] Continue button enabled after at least one selection

#### Screen 2: Posting Frequency (@specs/ui-mockups/onboarding-2.png)

**User Story**: As a content creator, I want to indicate how often I post so the app understands my workflow needs.

##### Actionable Steps:

1. Display question: "How often do you post?"
2. Show subtitle: "This helps me understand your workflow."
3. Present frequency options as large buttons:
   - Daily
   - Few times a week
   - Weekly
   - Few times a month
   - Rarely
4. Allow single selection only
5. Show "Continue" button at bottom
6. Update progress indicator to 40%

##### Acceptance Criteria:

- [x] All 5 frequency options are displayed
- [x] Single selection behavior (radio button style)
- [x] Visual feedback on selection
- [x] Progress bar shows 40% completion
- [x] Continue button enabled after selection

#### Screen 3: Content Type (@specs/ui-mockups/onboarding-3.png)

**User Story**: As a content creator, I want to specify what type of content I create so the app can build the right tools for me.

##### Actionable Steps:

1. Display question: "What do you create?"
2. Show subtitle: "This helps me build the right tools for you."
3. Present content type options:
   - Text posts & articles (Twitter threads, LinkedIn posts, Facebook updates)
   - Image content (Photos, graphics, memes, infographics)
   - Video content (Short videos, Reels, TikToks, YouTube content)
4. Allow multiple selections
5. Show "Continue" button at bottom
6. Update progress indicator to 60%

##### Acceptance Criteria:

- [x] All 3 content types are displayed with descriptions
- [x] Multiple selection is supported
- [x] Visual feedback on selection
- [x] Progress bar shows 60% completion
- [x] Continue button enabled after at least one selection

#### Screen 4: Pain Points (@specs/ui-mockups/onboarding-4.png)

**User Story**: As a content creator, I want to share my biggest challenges so the app can focus on solving my most important problems first.

##### Actionable Steps:

1. Display question: "What's your biggest challenge?"
2. Show subtitle: "This helps me solve your most important problems first."
3. Present pain point options:
   - Time management (Takes too long to post across platforms)
   - Consistency (Hard to maintain regular posting schedule)
   - Content ideas (Running out of things to post about)
   - Writing quality (Want better, more engaging content)
   - Formatting (Different requirements for each platform)
4. Allow selection of top 2 options
5. Show "Continue" button at bottom
6. Update progress indicator to 80%

##### Acceptance Criteria:

- [x] All 5 pain points are displayed with descriptions
- [x] Maximum 2 selections allowed
- [x] Visual feedback on selection
- [x] Progress bar shows 80% completion
- [x] Continue button enabled after at least one selection

#### Screen 5: OS Support Priority

**User Story**: As a user, I want to indicate which OS platform should be supported next so the app can prioritize development based on user demand.

##### Actionable Steps:

1. Display question: "Which OS should we support next?"
2. Show subtitle: "This helps us prioritize our development roadmap."
3. Present OS options as toggle buttons (same style as Screen 2):
   - iPadOS
   - macOS
4. Allow single selection only (radio button style)
5. Selection automatically proceeds to complete onboarding
6. Update progress indicator to 100%
7. Save preference data for development prioritization

##### Acceptance Criteria:

- [x] Both OS options are displayed clearly
- [x] Single selection behavior (radio button style)
- [x] Visual feedback on selection
- [x] Progress bar shows 100% completion
- [x] Selection automatically completes onboarding flow
- [x] OS preference data is saved for analytics

---

### Epic 3: Account Setup & Management

**User Story**: As a new user, I want to connect my social media accounts so I can start posting immediately.

#### Initial Setup Screen (@specs/ui-mockups/account-link-1.png)

**User Story**: As a user, I want to see which platforms are available and connect my accounts.

##### Actionable Steps:

1. Display "Setup channels" header
2. Show available platforms:
   - Threads (with Instagram logo and + button)
   - Bluesky (with Bluesky logo and + button)
3. Implement OAuth 2.0 authentication for each platform
4. Show connection status (connected/disconnected)
5. Allow users to skip and set up later

##### Acceptance Criteria:

- [ ] OAuth flows work for both Threads and Bluesky
- [ ] Connection status is clearly displayed
- [ ] Users can proceed without connecting accounts
- [ ] Error handling for failed connections

#### Connected Accounts Screen (@specs/ui-mockups/account-link-2.png)

**User Story**: As a user with connected accounts, I want to see my connected accounts and manage them.

##### Actionable Steps:

1. Display "Setup channels" header
2. Show connected accounts with profile info:
   - Account name (John Doe)
   - Platform icon
   - Green checkmark for connected status
3. Allow users to disconnect accounts
4. Provide option to add more accounts

##### Acceptance Criteria:

- [ ] Connected accounts are displayed with user info
- [ ] Account management functions work correctly
- [ ] Visual confirmation of connection status

---

### Epic 4: Content Creation & Posting

**User Story**: As a content creator, I want to write my content once and post it to multiple platforms simultaneously.

#### Main Composer Screen (@specs/ui-mockups/post.png)

**User Story**: As a user, I want to write my content and select which platforms to post to.

##### Actionable Steps:

1. Display platform selector at top left (shows connected accounts)
2. Show "+" button to add more accounts
3. Show settings/menu button at top right
4. Provide large text input area for content
5. Show character count and limits for selected platforms
6. Display send button (paper plane icon) when ready to post
7. Show keyboard with suggestions ("Hi", "I", "Ok")
8. Include emoji and voice input options

##### Acceptance Criteria:

- [ ] Text editor supports multi-line content
- [ ] Character counting works for each selected platform
- [ ] Platform selection affects character limits
- [ ] Send button is enabled when content and platforms are selected
- [ ] Keyboard integration works properly

#### Platform Selection (@specs/ui-mockups/post-select-channel.png)

**User Story**: As a user, I want to select which of my connected accounts to post to for this specific post.

##### Actionable Steps:

1. Display "Select channels" header with back arrow
2. Show checkmark button in top right for confirmation
3. List connected accounts with:
   - Profile picture and name
   - Platform identification
   - Toggle switch for selection
4. Allow multiple platform selection
5. Save selection and return to composer

##### Acceptance Criteria:

- [ ] All connected accounts are listed
- [ ] Toggle switches work correctly
- [ ] Selection is saved when returning to composer
- [ ] Visual feedback for selected/unselected accounts

---

### Epic 5: Settings & Account Management

**User Story**: As a user, I want to manage my app settings and subscription.

#### Settings Screen (@specs/ui-mockups/settings.png)

**User Story**: As a user, I want to access my subscription status and app settings.

##### Actionable Steps:

1. Display "Settings" header with close button
2. Show subscription status card:
   - "Diggie Pro (Early Bird)"
   - "$7.99/month forever (47% off)"
   - Profile icon
3. Display "Others" section with:
   - Privacy Policy (with arrow)
   - Contact Support (with arrow)
4. Show "Remove All Accounts" button (destructive action)

##### Acceptance Criteria:

- [ ] Subscription status is accurately displayed
- [ ] Privacy Policy and Contact Support links work
- [ ] Remove All Accounts has confirmation dialog
- [ ] RevenueCat subscription management integration

---

## Technical Implementation Stories

### Epic 6: Core Infrastructure

**User Story**: As a developer, I need robust technical infrastructure to support the app functionality.

#### Actionable Steps:

1. **App Architecture**

   - [x] Set up SwiftUI project with iOS 15+ target
   - [x] Implement MVVM architecture pattern
   - [x] Create navigation coordinator

2. **Authentication System**

   - [ ] Integrate OAuth 2.0 for Threads
   - [ ] Integrate OAuth 2.0 for Bluesky AT Protocol
   - [ ] Implement secure token storage
   - [ ] Handle token refresh logic

3. **API Integration**

   - [ ] Create Threads API service
   - [ ] Create Bluesky API service
   - [ ] Implement posting functionality
   - [ ] Add error handling and retry logic

4. **Subscription Management (RevenueCat)**

   - [ ] Integrate RevenueCat SDK
   - [ ] Configure RevenueCat dashboard and API keys
   - [ ] Set up subscription products in App Store Connect:
     - [ ] Early Bird subscription ($7.99/month)
     - [ ] Regular Premium subscription ($14.99/month)
   - [ ] Configure RevenueCat products and entitlements:
     - [ ] Map App Store products to RevenueCat offerings
     - [ ] Set up "early_bird" and "premium" entitlements
     - [ ] Configure promotional offers for early bird pricing
   - [ ] Implement paywall presentation:
     - [ ] Create paywall UI for onboarding Screen 5
     - [ ] Implement purchase flow with RevenueCat
     - [ ] Add loading states and purchase confirmation
     - [ ] Handle purchase errors and edge cases
   - [ ] Implement subscription state management:
     - [ ] Check subscription status on app launch
     - [ ] Update UI based on subscription entitlements
     - [ ] Handle subscription expiration and renewal
     - [ ] Implement subscription restoration
   - [ ] Add subscription analytics integration:
     - [ ] Track subscription events in PostHog
     - [ ] Monitor conversion rates by user segment
     - [ ] Track subscription lifecycle events
     - [ ] Measure early bird vs regular pricing performance
   - [ ] Implement subscription management features:
     - [ ] Display subscription status in Settings
     - [ ] Handle subscription changes and cancellations
     - [ ] Provide customer support integration
     - [ ] Add subscription receipt validation

5. **Data Management**

   - [x] Implement onboarding data storage
   - [x] Create user preferences system
   - [ ] Add account management data layer

6. **Analytics Integration**
   - [ ] Integrate PostHog SDK
   - [ ] Configure PostHog project and API key
   - [ ] Implement onboarding analytics tracking:
     - [ ] Track onboarding screen views (Screen 1-5)
     - [ ] Track platform selections and combinations
     - [ ] Track posting frequency choices
     - [ ] Track content type selections
     - [ ] Track pain point selections
     - [ ] Track early bird vs free tier choices
     - [ ] Track onboarding completion rate by screen
     - [ ] Track onboarding drop-off points
   - [ ] Add user segmentation properties:
     - [ ] Creator persona classification (Text/Visual/Video)
     - [ ] Platform preference groupings
     - [ ] Pain point clusters
     - [ ] Posting frequency segments
   - [ ] Implement conversion funnel tracking:
     - [ ] App launch → Onboarding start
     - [ ] Onboarding start → Screen completion rates
     - [ ] Onboarding completion → Account connection
     - [ ] Account connection → First post
     - [ ] Free tier → Early bird conversion
   - [ ] Add privacy-compliant event tracking
   - [ ] Implement user identification for cohort analysis

---

## Acceptance Criteria Summary

### MVP Success Criteria:

- [x] Complete onboarding flow with 5 screens
- [ ] Successful OAuth integration for Threads and Bluesky
- [ ] Functional text composer with character counting
- [ ] Multi-platform posting capability
- [ ] RevenueCat subscription system
- [ ] Settings and account management
- [ ] Error handling throughout the app
- [x] Smooth transitions between screens
- [x] Responsive UI that works on all iPhone sizes
- [ ] App Store submission ready

### Performance Requirements:

- [ ] App launches in under 2 seconds
- [ ] Posts publish in under 15 seconds
- [ ] Smooth 60fps animations throughout
- [ ] Offline text composition capability
- [ ] Memory usage under 50MB

### User Experience Requirements:

- [ ] Intuitive navigation without tutorials needed
- [ ] Clear visual feedback for all user actions
- [ ] Accessibility support (VoiceOver, Dynamic Type)
- [ ] Error messages are helpful and actionable
- [ ] Onboarding completion rate target: 70%

This user story breakdown provides a clear roadmap for development teams to implement the Diggie MVP, with each story containing specific, measurable, and testable acceptance criteria.

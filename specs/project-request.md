# Diggie - Product Requirements Document (MVP)

## Product Overview

**Product Name:** Diggie (MVP)  
**Platform:** iOS (SwiftUI)  
**Target Audience:** Content creators who need simple cross-platform posting  
**Vision:** Validate market demand for unified content creation with fastest possible launch  
**Timeline:** 4-6 weeks to App Store

## Problem Statement

Content creators waste time switching between apps to post the same content across multiple social platforms. They need a simple, unified writing interface that can post to multiple platforms simultaneously.

## MVP Solution

A minimal viable product focusing on core functionality:

- Simple onboarding to understand user needs and willingness to pay
- Social media account linking
- Basic content writing interface
- Cross-posting to free platforms (Threads, Bluesky)
- Premium tier preview for Twitter/X integration

## Core MVP Features

### 1. Onboarding Flow (2-3 Screens Maximum)

#### Screen 1: Platform Selection

- **Question**: "Which platforms do you currently use?"
- **Options**: Threads, Bluesky, Twitter/X, LinkedIn, Facebook (checkbox selection)
- **Purpose**: Understand user's platform mix and prioritize integrations

#### Screen 2: Value Proposition & Pricing

- **Message**: "Currently free for Threads and Bluesky"
- **Question**: "Would you pay $14.99/month for Twitter/X integration when available?"
- **Early Bird Hook**: "Join early access for $7.99/month forever (47% off) and get:"
  - ✅ Twitter/X integration (coming soon)
  - ✅ AI-powered writing assistant
  - ✅ Content scheduling & calendar
  - ✅ Advanced content tools
  - ✅ Priority support & early feature access
- **Options**: "Yes, lock in early bird pricing" / "Maybe at regular price" / "No, free tier only"
- **Purpose**: Validate willingness to pay and build early access list with strong incentive

#### Screen 3: Quick Setup

- **Message**: "Let's connect your accounts to get started"
- **Action**: Direct to account linking
- **Purpose**: Immediate onboarding to core functionality

### 2. Early Bird Promotion

- **Free Tier**: Full access to Threads and Bluesky posting
- **Early Bird Offer**: "Lock in $7.99/month forever when premium launches"
- **Early Bird Benefits**:
  - 47% off regular price ($14.99) forever
  - Twitter/X integration (first premium platform)
  - AI-powered content creation tools
  - Content scheduling & calendar management
  - Advanced formatting and templates
  - Priority customer support
  - Exclusive early access to new features
  - Lifetime price protection
- **Regular Premium Price**: $14.99/month (competitive with market standards)
- **Waitlist**: Email collection for premium feature updates
- **Timeline Communication**: "Premium features launching in 6-8 weeks"

### 3. Account Linking

- **Supported Platforms**: Threads, Bluesky
- **UI**: Simple list with connect/disconnect toggles
- **Authentication**: OAuth 2.0/API flows specific to each platform
- **Status Indicators**: Connected/Disconnected with clear visual feedback
- **Premium Platforms**: Show Twitter/X, LinkedIn, Facebook as "Premium - Coming Soon"

### 4. Content Writing Interface

- **Simple Text Editor**: Basic SwiftUI TextEditor with character counting
- **Platform Toggles**: Checkboxes to select which platforms to post to
- **Character Limits**: Real-time count for each platform
- **Post Button**: Single action to publish to selected platforms
- **Success/Error Feedback**: Clear confirmation of successful posts

## Removed Features (Moving to Phase 1.5)

- Rich text formatting
- Draft management
- Content templates
- Hashtag suggestions
- Analytics dashboard
- Content library/history
- Advanced scheduling
- Team collaboration
- Content preview
- Image/media upload

## User Stories (MVP Only)

### Primary MVP Stories

1. **As a new user**, I want to quickly understand what platforms are supported, so I can decide if this app fits my needs
2. **As a content creator**, I want to know the pricing upfront, so I can make an informed decision
3. **As a user**, I want to connect my social accounts easily, so I can start posting immediately
4. **As a creator**, I want to write once and post to multiple platforms, so I save time on content distribution
5. **As an early adopter**, I want to secure early bird pricing, so I get value when premium features launch

## Technical Requirements (Simplified)

### iOS/SwiftUI Specifications

- **Minimum iOS Version**: iOS 15.0 (broader compatibility)
- **Architecture**: Simple MVVM with SwiftUI
- **Data Persistence**: UserDefaults for basic settings (no Core Data needed)
- **Networking**: URLSession with async/await for API calls
- **Authentication**: OAuth 2.0/API flows specific to each platform

### Platform API Integration (MVP Only)

- **Threads API**: Meta's Threads API for Business (when available) or web automation
- **Bluesky API**: AT Protocol integration for posting
- **Twitter/X API**: Placeholder UI only (premium tier messaging)
- **LinkedIn/Facebook**: Coming to premium tier after user validation

### Performance Requirements (MVP)

- App launch time: < 2 seconds
- Content posting: < 15 seconds per platform
- Authentication flow: < 30 seconds per platform
- Offline capability: Basic text editing only
- Memory usage: < 50MB

## User Interface Design (MVP)

### Core Screens (4 Total)

1. **Onboarding Flow** (3 screens): Platform selection → Pricing → Account linking
2. **Main Writing Screen**: Text editor with platform toggles and post button
3. **Account Management**: Simple list of connected accounts
4. **Settings**: Basic app preferences and early bird offer access

### Design Principles (MVP)

- **Ultra-Simple Design**: Zero learning curve for new users
- **Platform Visual Cues**: Small icons to identify each platform
- **Clear CTAs**: Obvious buttons for primary actions
- **Accessibility**: Basic VoiceOver support and readable fonts
- **Single-Purpose Screens**: Each screen has one clear objective

## Success Metrics (MVP)

### Primary KPIs (Validation Focused)

- **App Downloads**: 500 downloads within first month
- **Onboarding Completion**: 70% of downloads complete onboarding
- **Account Connections**: 60% of users connect at least one platform
- **First Post**: 40% of users publish their first cross-post within 24 hours
- **Early Bird Signups**: 25% conversion rate from onboarding to early bird list

### Key Validation Metrics

- **Willingness to Pay**: Percentage saying "yes" to Twitter/X premium pricing
- **Platform Usage**: Which free platforms are most connected/used
- **User Retention**: 7-day and 30-day retention rates
- **Organic Growth**: Share rate and word-of-mouth indicators
- **Feedback Quality**: App Store reviews and user-submitted feedback

### Revenue Validation

- **Early Bird Conversion**: Target 100+ early bird subscribers at $7.99/month
- **Pricing Validation**: Test willingness to pay $14.99 regular price vs $7.99 early bird
- **Feature Demand**: Track requests for specific missing features
- **Revenue Projection**: 100 early bird users = $799/month recurring revenue base

## Development Timeline (MVP)

### Week 1-2: Foundation

- SwiftUI app structure and navigation
- Onboarding flow UI and logic
- Basic settings and user preferences
- App Store Connect setup

### Week 3-4: Core Functionality

- API integration for Threads and Bluesky
- Basic text editor with character counting
- Platform selection and posting logic
- Error handling and user feedback

### Week 5-6: Polish & Launch

- UI/UX refinements and testing
- Early bird promotion implementation
- App Store screenshots and metadata
- Beta testing with small user group
- App Store submission

## Monetization Strategy (MVP)

### Free Tier

- Full access to Threads and Bluesky posting
- Basic text editor with character limits
- Account management
- No time limits or post quotas

### Premium Tier Preview ($14.99/month)

- Twitter/X integration (first premium platform)
- AI-powered writing and content optimization
- Content scheduling and calendar management
- Advanced content formatting and templates
- Media upload and editing capabilities
- LinkedIn and Facebook integration (coming later)
- Priority customer support and feature requests
- Early access to beta features

### Early Bird Campaign

- **Pre-launch**: Build waitlist during development
- **Launch Week**: Heavy promotion of early bird pricing ($7.99 vs $14.99)
- **Timeline**: 30-day early bird window before premium launches
- **Goal**: 100+ early bird subscribers to validate premium tier

## Risk Assessment (MVP)

### Technical Risks (Minimized)

- **API Rate Limits**: Start with conservative posting limits
- **Authentication Issues**: Focus on robust OAuth implementation
- **Platform Policy Changes**: Monitor API terms closely

### Market Risks

- **User Adoption**: Simple onboarding reduces friction
- **Competition Response**: Quick launch minimizes competitive response time
- **Feature Expectations**: Clear communication about MVP scope

### Mitigation Strategies

- **Rapid Iteration**: Weekly app updates based on user feedback
- **Community Building**: Engage early users for product direction
- **Clear Roadmap**: Transparent communication about upcoming features

## Phase 1.5 Pipeline

### Features Moving to Next Release (6-8 weeks post-MVP)

- **Twitter/X Integration**: First premium tier launch (priority when paying users exist)
- **AI-Powered Writing Assistant**: Content generation and optimization
- **Media Upload & Management**: Image and video support
- **Draft Management**: Save and manage multiple drafts
- **Content Templates**: Pre-built templates for different content types
- **Content Scheduling**: Calendar management and automated posting
- **Rich Text Formatting**: Bold, italic, links
- **Content Preview**: See how posts will look on each platform
- **LinkedIn/Facebook Integration**: Added to premium tier after Twitter/X success

### User Feedback Integration Points

- **Feature Prioritization**: Let user votes guide Phase 1.5 development
- **UI Improvements**: Based on actual usage patterns
- **New Platform Requests**: TikTok, Pinterest, etc. based on demand

## Success Criteria for MVP

### Launch Success

- 500+ downloads in first 30 days
- 4.0+ App Store rating
- 100+ early bird subscribers
- 30%+ user retention after 7 days

### Validation Success

- 60%+ of users connect at least one social account
- 40%+ of users publish their first cross-post
- 25%+ conversion to early bird offer
- Clear evidence of willingness to pay for premium features

### Market Fit Indicators

- Organic growth through word-of-mouth
- High engagement in onboarding flow
- Frequent app usage (multiple posts per week)
- Strong qualitative feedback requesting more features

## Next Steps

1. **Immediate**: Begin SwiftUI development with focus on onboarding flow
2. **Week 2**: Start social media API integration setup
3. **Week 4**: Begin early bird marketing campaign preparation
4. **Week 6**: Submit to App Store and launch marketing
5. **Post-Launch**: Daily monitoring of user feedback and usage analytics

## Conclusion

This MVP approach for Diggie focuses on rapid market validation while building the foundation for a comprehensive content creation platform. By limiting scope to essential features and emphasizing user feedback collection, we can quickly determine product-market fit and iterate based on real user needs.

The early bird promotion strategy not only validates willingness to pay but also creates a committed user base for future feature releases. Success in this MVP phase will provide clear direction for Phase 1.5 development and long-term product strategy.

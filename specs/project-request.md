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

- Enhanced onboarding to understand user needs, content types, and willingness to pay
- Social media account linking
- Basic content writing interface
- Cross-posting to free platforms (Threads, Bluesky)
- Premium tier preview for Twitter/X integration

## Core MVP Features

### 1. Enhanced Onboarding Flow (5 Screens)

#### Screen 1: Platform Selection

- **Question**: "Which platforms do you currently use for content creation?"
- **Subtitle**: _This helps me understand which platform integrations to prioritize_
- **Options**: Threads, Bluesky, Twitter/X, LinkedIn, Facebook, Instagram, TikTok, YouTube (checkbox selection)
- **Purpose**: Understand platform mix and prioritize integrations

#### Screen 2: Posting Frequency

- **Question**: "How often do you post on these platforms?"
- **Subtitle**: _This helps me understand your content creation workflow_
- **Options**:
  - Daily
  - Few times a week
  - Weekly
  - Few times a month
- **Purpose**: Understand posting frequency and usage patterns

#### Screen 3: Content Type Assessment

- **Question**: "What type of content do you primarily create?" (Select all that apply)
- **Subtitle**: _This helps me build the right tools for your content workflow_
- **Options**:
  - 📝 **Text posts & articles** (Twitter threads, LinkedIn posts, Facebook updates)
  - 📸 **Image content** (Photos, graphics, memes, infographics)
  - 🎥 **Video content** (Short videos, Reels, TikToks, YouTube content)
  - 📊 **Business content** (Product updates, company news, professional posts)
  - 🎨 **Creative content** (Art, photography, creative writing)
  - 📰 **News & commentary** (Current events, opinion pieces, discussions)
  - 🏢 **Brand/Marketing** (Promotional content, campaigns, brand awareness)
  - 👥 **Personal brand** (Lifestyle, personal updates, thought leadership)

#### Screen 4: Content Creation Pain Points

- **Question**: "What's your biggest challenge with content creation?" (Select top 2)
- **Subtitle**: _This helps me focus on solving your most important problems first_
- **Options**:
  - ⏰ **Time management** - Takes too long to post across platforms
  - 🔄 **Consistency** - Hard to maintain regular posting schedule
  - 💡 **Content ideas** - Running out of things to post about
  - ✍️ **Writing quality** - Want better, more engaging content
  - 📐 **Formatting** - Different requirements for each platform
  - 📈 **Growth** - Not seeing engagement or follower growth
  - 🎯 **Strategy** - Don't have a clear content strategy
  - 🛠️ **Tools** - Current tools are too complex or limited

#### Screen 5: Value Proposition & Pricing

- **Personalized Message** based on previous answers:
  - For video creators: "Perfect for creators who want to repurpose video content across platforms"
  - For text creators: "Ideal for writers who want to maximize their reach"
  - For business users: "Built for professionals who need efficient content distribution"
- **Current Offering**: "Currently free for Threads and Bluesky"
- **Premium Preview**: Show relevant features based on content type selected
- **Early Bird Offer**: Same as before but with personalized benefits

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
6. **As a user**, I want the app to understand my content type and pain points, so I get relevant features

## Technical Requirements (Simplified)

### iOS/SwiftUI Specifications

- **Minimum iOS Version**: iOS 15.0 (broader compatibility)
- **Architecture**: Simple MVVM with SwiftUI
- **Data Persistence**: SwiftData for onboarding preferences and UserDefaults for basic settings
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

### Core Screens (6 Total)

1. **Onboarding Flow** (5 screens): Platform selection → Posting frequency → Content type → Pain points → Pricing
2. **Main Writing Screen**: Text editor with platform toggles and post button
3. **Account Management**: Simple list of connected accounts
4. **Settings**: Basic app preferences and early bird offer access

### Design Principles (MVP)

- **Ultra-Simple Design**: Zero learning curve for new users
- **Platform Visual Cues**: Small icons to identify each platform
- **Clear CTAs**: Obvious buttons for primary actions
- **Accessibility**: Basic VoiceOver support and readable fonts
- **Single-Purpose Screens**: Each screen has one clear objective
- **Personalized Experience**: Interface adapts based on onboarding responses

## Success Metrics (MVP)

### Primary KPIs (Validation Focused)

- **App Downloads**: 500 downloads within first month
- **Onboarding Completion**: 70% of downloads complete full onboarding
- **Account Connections**: 60% of users connect at least one platform
- **First Post**: 40% of users publish their first cross-post within 24 hours
- **Early Bird Signups**: 25% conversion rate from onboarding to early bird list

### Enhanced Onboarding Analytics

#### Platform Usage Metrics

- **Platform Distribution**: Percentage of users selecting each platform
- **Multi-Platform Users**: Percentage using 2+, 3+, 4+ platforms
- **Posting Frequency**: Distribution of how often users post
- **Platform Combinations**: Most common platform pairs/groups

#### Content Type Analytics

- **Primary Content Types**: Distribution of content creation focus
- **Content Complexity**: Single vs. multiple content type creators
- **Video vs. Text Ratio**: Percentage focusing on video vs. text content
- **Business vs. Personal**: Professional vs. personal content creators

#### Pain Point Insights

- **Top Pain Points**: Ranking of most common challenges
- **Pain Point Clusters**: Common combinations of challenges
- **Feature Demand Prediction**: Match pain points to planned features
- **User Segmentation**: Group users by similar pain point profiles

### Advanced User Segmentation

#### Content Creator Personas (Based on Onboarding Data)

1. **Text-First Creators** (Focus: Writing, Articles, Threads)

   - Primary platforms: Twitter/X, LinkedIn, Threads
   - Pain points: Time management, writing quality
   - Premium features: AI writing assistant, formatting rules

2. **Visual Content Creators** (Focus: Images, Graphics)

   - Primary platforms: Instagram, Facebook, LinkedIn
   - Pain points: Formatting, consistency
   - Premium features: Media editing, templates

3. **Video Content Creators** (Focus: Short videos, Reels)

   - Primary platforms: TikTok, Instagram, YouTube
   - Pain points: Time management, repurposing content
   - Premium features: Video editing, auto-cropping

4. **Business/Professional** (Focus: Brand, Marketing)

   - Primary platforms: LinkedIn, Facebook, Twitter/X
   - Pain points: Strategy, consistency, growth
   - Premium features: Scheduling, analytics, team features

5. **Multi-Format Creators** (Focus: Mixed content)
   - Primary platforms: All platforms
   - Pain points: Tool complexity, time management
   - Premium features: All features, workflow optimization

### Key Validation Metrics

- **Willingness to Pay**: Percentage saying "yes" to Twitter/X premium pricing
- **Platform Usage**: Which free platforms are most connected/used
- **User Retention**: 7-day and 30-day retention rates by segment
- **Organic Growth**: Share rate and word-of-mouth indicators
- **Feedback Quality**: App Store reviews and user-submitted feedback
- **Feature Request Alignment**: Match requested features to onboarding data

### Revenue Validation

- **Early Bird Conversion**: Target 100+ early bird subscribers at $7.99/month
- **Pricing Validation**: Test willingness to pay $14.99 regular price vs $7.99 early bird
- **Feature Demand**: Track requests for specific missing features
- **Revenue Projection**: 100 early bird users = $799/month recurring revenue base
- **Segment-Based Conversion**: Premium conversion rates by creator type

## Development Timeline (MVP)

### Week 1-2: Foundation

- SwiftUI app structure and navigation
- Enhanced onboarding flow UI and logic
- SwiftData implementation for user preferences
- Basic settings and user preferences
- App Store Connect setup

### Week 3-4: Core Functionality

- API integration for Threads and Bluesky
- Basic text editor with character counting
- Platform selection and posting logic
- Error handling and user feedback
- Personalization logic based on onboarding

### Week 5-6: Polish & Launch

- UI/UX refinements and testing
- Early bird promotion implementation
- Analytics integration for onboarding metrics
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
- **Personalization**: Targeted benefits based on creator type

## Risk Assessment (MVP)

### Technical Risks (Minimized)

- **API Rate Limits**: Start with conservative posting limits
- **Authentication Issues**: Focus on robust OAuth implementation
- **Platform Policy Changes**: Monitor API terms closely
- **Data Management**: Ensure SwiftData handles onboarding data reliably

### Market Risks

- **User Adoption**: Enhanced onboarding reduces friction and increases relevance
- **Competition Response**: Quick launch minimizes competitive response time
- **Feature Expectations**: Clear communication about MVP scope and roadmap

### Mitigation Strategies

- **Rapid Iteration**: Weekly app updates based on user feedback
- **Community Building**: Engage early users for product direction
- **Clear Roadmap**: Transparent communication about upcoming features
- **Data-Driven Decisions**: Use onboarding analytics to guide development

## Personalized Feature Prioritization

### Phase 1.5 Feature Ranking by User Segment

Based on onboarding responses, prioritize features for each segment:

**Text-First Creators**:

1. AI-powered writing assistant (addresses writing quality)
2. Content formatting rules (addresses formatting challenges)
3. Thread/long-form content tools
4. Grammar and style suggestions

**Visual Content Creators**:

1. Media upload and basic editing (core need)
2. Platform-specific image sizing (addresses formatting)
3. Template system for graphics
4. Stock photo integration

**Video Content Creators**:

1. Video upload and basic editing (core need)
2. Auto-cropping for different aspect ratios
3. Video templates and overlays
4. Cross-platform video optimization

**Business/Professional**:

1. Content scheduling and calendar (addresses consistency)
2. Team collaboration features
3. Analytics and performance tracking
4. Brand kit and style management

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

- **Feature Prioritization**: Let user votes and onboarding data guide Phase 1.5 development
- **UI Improvements**: Based on actual usage patterns and creator type preferences
- **New Platform Requests**: TikTok, Pinterest, etc. based on demand from specific segments

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
- 70%+ onboarding completion rate

### Market Fit Indicators

- Organic growth through word-of-mouth
- High engagement in onboarding flow
- Frequent app usage (multiple posts per week)
- Strong qualitative feedback requesting more features
- Clear user segmentation patterns matching planned features

## Next Steps

1. **Immediate**: Begin SwiftUI development with focus on enhanced onboarding flow
2. **Week 2**: Start social media API integration setup and SwiftData implementation
3. **Week 4**: Begin early bird marketing campaign preparation with segment-based messaging
4. **Week 6**: Submit to App Store and launch marketing with personalized onboarding
5. **Post-Launch**: Daily monitoring of user feedback, usage analytics, and segment behavior

## Conclusion

This enhanced MVP approach for Diggie focuses on rapid market validation while building deep user understanding through comprehensive onboarding. By collecting detailed data about content types, pain points, and platform usage, we can quickly determine product-market fit and iterate based on real user needs and segments.

The enhanced onboarding flow not only validates willingness to pay but also creates personalized user experiences and provides rich data for feature prioritization. Success in this MVP phase will provide clear direction for Phase 1.5 development and long-term product strategy based on actual user segments and needs.

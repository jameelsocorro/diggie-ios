# Diggie - MVP Roadmap (Simplified)

## Overview

**Goal**: Launch a simple cross-platform posting app
**Vision**: The ultimate content creation platform for creators and social media managers  
**Mission**: Empower creators with seamless cross-platform content distribution and management  
**Problem**: Content creators waste time switching between apps to post the same content across multiple social platforms  
**Platforms**: iOS only (SwiftUI)

---

## What We're Building (MVP Features)

### 0. Welcome Screens

**Welcome Screen**

- Display Diggie logo with gradient background
- Show tagline: "One post. Everywhere. Instantly."
- Present "Try it for free" CTA button
- Transition to onboarding flow on button tap

### 1. Smart Onboarding (5 Quick Screens)

**Screen 1: Platform Selection**

- "Which platforms do you use?"
- _This helps me prioritize which integrations to build first_
- **Options**: Threads, Bluesky, Twitter/X, LinkedIn, Instagram (checkbox selection)

**Screen 2: Posting Frequency**

- "How often do you post?"
- _This helps me understand your workflow_
- **Options**: Daily, Few times a week, Weekly, Few times a month, Rarely

**Screen 3: Content Type**

- "What do you create?" (Select all that apply)
- _This helps me build the right tools for you_
- **Options**:
  - Text posts & articles (Twitter threads, LinkedIn posts, Facebook updates)
  - Image content (Photos, graphics, memes, infographics)
  - Video content (Short videos, Reels, TikToks, YouTube content)

**Screen 4: Pain Points**

- "What's your biggest challenge?" (Select top 2)
- _This helps me solve your most important problems first_
- **Options**:
  - Time management - Takes too long to post across platforms
  - Consistency - Hard to maintain regular posting schedule
  - Content ideas - Running out of things to post about
  - Writing quality - Want better, more engaging content
  - Formatting - Different requirements for each platform

**Screen 5: OS Support Priority**

- "Which OS should we support next?"
- _This helps us prioritize our development roadmap_
- **Options**: iPadOS, macOS (single selection)
- Selection automatically completes onboarding

### 2. Simple Posting Interface

- Basic text editor with character counting
- Toggle which platforms to post to
- One-tap posting to selected platforms
- Success/error messages

### 3. Account Linking

- Connect Threads account
- Connect Bluesky account
- Show premium platforms as "Coming Soon"

### 4. Basic Settings

- Manage connected accounts
- Access early bird offer
- Update preferences

---

## What's NOT in MVP (Coming Later)

- ❌ Rich text formatting
- ❌ Image/video uploads
- ❌ Content scheduling
- ❌ Draft saving
- ❌ Analytics
- ❌ AI writing assistant
- ❌ Team features

---

## Pricing Strategy

### Free Tier

- Post to Threads and Bluesky
- Basic text editor
- Account management
- No limits on posts

### Premium Tier (Coming Soon)

- **Early Bird**: $7.99/month forever (47% off)
- **Regular Price**: $14.99/month
- **Includes**: Twitter/X, LinkedIn, Facebook, AI writing, scheduling, media uploads

---

## Technical Requirements

### Simple Tech Stack

- **iOS App**: SwiftUI (iOS 15+)
- **APIs**: Threads API, Bluesky AT Protocol
- **Authentication**: OAuth 2.0
- **Subscriptions**: RevenueCat

### Performance Goals

- App launches in under 2 seconds
- Posts publish in under 15 seconds
- Works offline for writing (posts when online)

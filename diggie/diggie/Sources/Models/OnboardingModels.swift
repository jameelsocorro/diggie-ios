//
//  OnboardingModels.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import Foundation

/// Platform options for onboarding
enum Platform: String, CaseIterable, Identifiable {
    case x = "x"
    case threads = "threads"
    case bluesky = "bluesky"
    case mastodon = "mastodon"
    case linkedin = "linkedin"
    case youtube = "youtube"
    case youtubeShorts = "youtube_shorts"
    case instagram = "instagram"
    case tiktok = "tiktok"
    case others = "others"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .x: return "X (Twitter)"
        case .threads: return "Threads"
        case .bluesky: return "Bluesky"
        case .mastodon: return "Mastodon"
        case .linkedin: return "LinkedIn"
        case .youtube: return "YouTube"
        case .youtubeShorts: return "YouTube Shorts"
        case .instagram: return "Instagram"
        case .tiktok: return "TikTok"
        case .others: return "Others"
        }
    }
    
    /// Asset name for platform icon
    var iconName: String? {
        switch self {
        case .x: return "Twitter"
        case .threads: return "Threads"
        case .bluesky: return "Bluesky"
        case .mastodon: return "Mastodon"
        case .linkedin: return "LinkedIn"
        case .youtube: return "Youtube"
        case .youtubeShorts: return "Youtube" // Using same icon as YouTube
        case .instagram: return "Instagram"
        case .tiktok: return "Tiktok"
        case .others: return nil
        }
    }
}

/// Posting frequency options
enum PostingFrequency: String, CaseIterable, Identifiable {
    case daily = "daily"
    case fewTimesWeek = "few_times_week"
    case weekly = "weekly"
    case fewTimesMonth = "few_times_month"
    case rarely = "rarely"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .daily: return "Daily"
        case .fewTimesWeek: return "Few times a week"
        case .weekly: return "Weekly"
        case .fewTimesMonth: return "Few times a month"
        case .rarely: return "Rarely"
        }
    }
}

/// Content type options
enum ContentType: String, CaseIterable, Identifiable {
    case textPosts = "text_posts"
    case imageContent = "image_content"
    case videoContent = "video_content"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .textPosts: return "Text posts & articles"
        case .imageContent: return "Image content"
        case .videoContent: return "Video content"
        }
    }
    
    var description: String {
        switch self {
        case .textPosts: return "Twitter threads, LinkedIn posts, Facebook updates"
        case .imageContent: return "Photos, graphics, memes, infographics"
        case .videoContent: return "Short videos, Reels, TikToks, YouTube content"
        }
    }
}

/// Pain point options
enum PainPoint: String, CaseIterable, Identifiable {
    case timeManagement = "time_management"
    case consistency = "consistency"
    case contentIdeas = "content_ideas"
    case writingQuality = "writing_quality"
    case formatting = "formatting"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .timeManagement: return "Time management"
        case .consistency: return "Consistency"
        case .contentIdeas: return "Content ideas"
        case .writingQuality: return "Writing quality"
        case .formatting: return "Formatting"
        }
    }
    
    var description: String {
        switch self {
        case .timeManagement: return "Takes too long to post across platforms"
        case .consistency: return "Hard to maintain regular posting schedule"
        case .contentIdeas: return "Running out of things to post about"
        case .writingQuality: return "Want better, more engaging content"
        case .formatting: return "Different requirements for each platform"
        }
    }
}
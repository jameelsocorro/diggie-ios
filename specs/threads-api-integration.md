# Threads API Integration Checklist

## Phase 1: Meta App Setup & Configuration

- [ ] Create Meta App with "Threads" use case on Meta Developer Console
- [ ] Configure app settings and obtain CLIENT_ID/CLIENT_SECRET
- [ ] Set up redirect URIs for iOS app
- [ ] Add Threads configuration to Info.plist
- [ ] Configure URL schemes for OAuth callback
- [ ] Add necessary network permissions

## Phase 2: Authentication Infrastructure

- [ ] Create ThreadsAuthService with OAuth 2.0 flow
- [ ] Implement SafariServices for web authentication
- [ ] Handle authorization URL generation
- [ ] Manage token exchange (short-lived → long-lived)
- [ ] Implement token refresh logic
- [ ] Update AccountModels with ThreadsAccount model
- [ ] Add OAuth tokens and expiration properties
- [ ] Update SocialPlatform enum for Threads

## Phase 3: Secure Storage & API Layer

- [ ] Implement Keychain storage for access tokens
- [ ] Add token encryption/decryption utilities
- [ ] Handle token lifecycle management
- [ ] Create ThreadsAPIService with authenticated HTTP client
- [ ] Add publishing endpoints (text, media, carousel)
- [ ] Add rate limiting and quota management
- [ ] Handle API error responses
- [ ] Add media upload functionality
- [ ] Support image/video preprocessing
- [ ] Implement media URL hosting solution

## Phase 4: UI Integration

- [ ] Modify InitialSetupScreen for Threads OAuth
- [ ] Add real OAuth webview integration
- [ ] Update ConnectedAccountsScreen with token status
- [ ] Create ThreadsPostComposer view
- [ ] Add media picker integration
- [ ] Implement character count (500 limit)
- [ ] Add publishing status indicators

## Phase 5: Testing & Validation

- [ ] Add mock ThreadsAPIService for previews
- [ ] Create test accounts and tokens
- [ ] Add unit tests for authentication flow
- [ ] Test token refresh scenarios
- [ ] Add comprehensive error handling
- [ ] Implement user-friendly error messages
- [ ] Add retry logic for network failures
- [ ] Handle rate limiting gracefully

## API Reference

### Authentication Endpoints
- Authorization URL: `https://threads.net/oauth/authorize`
- Access Token Exchange: `https://graph.threads.net/oauth/access_token`
- Long-lived Token Exchange: `https://graph.threads.net/access_token`

### Publishing Endpoints
- Base URL: `https://graph.threads.net`
- Publish Content: `POST /{threads-user-id}/threads_publish`
- Publishing Limit: `GET /{threads-user-id}/threads_publishing_limit`

### Rate Limits
- 250 API-published posts per 24 hours
- 1,000 replies per 24 hours
- Text posts limited to 500 characters
- Carousel posts must have 2-20 children

### Required Permissions
- `threads_basic` (required for all endpoints)
- `threads_content_publish` (for publishing)
- `threads_manage_replies` (for reply management)
- `threads_read_replies` (for reading replies)
- `threads_manage_insights` (for insights)

### Token Lifecycle
- Short-lived tokens: Valid for 1 hour
- Long-lived tokens: Valid for 60 days
- Tokens for public profiles: Valid for 90 days
- Automatic refresh required before expiration

# UNIVERSAL AI & HUMAN SOFTWARE ARCHITECT BIBLE

Flutter Project Engineering Standard, AI Decision Engine, and Architecture Blueprint

This file is the project-specific implementation constitution. It inherits the reasoning, truthfulness, safety, and self-review principles from `.agents/00_AI_OPERATING_SYSTEM.md`. When rules conflict, preserve existing production behavior, security, data integrity, platform compliance, and explicit user requirements in that order; document the decision.

Never prioritize cleaner code over preserving required existing behavior.

------------------------------------------------------------------------

# Objectives

Every implementation must improve:

-   Performance
-   Readability
-   Maintainability
-   Reusability
-   Scalability
-   User Experience
-   Consistency

Always think like a senior engineer reviewing code before merging into
production.

------------------------------------------------------------------------

# Tech Stack

-   Flutter (Latest Stable)
-   Dart
-   GetX
-   HTTP
-   Flutter EasyLoading

Never introduce another state management library unless explicitly
requested.

------------------------------------------------------------------------

# Architecture

Always use Feature-Based Architecture.

Preferred feature structure:

``` text
feature_name/
├── controllers/
├── screens/
├── widgets/
```

If the feature contains multiple endpoints or reusable networking logic:

``` text
feature_name/
├── controllers/
├── screens/
├── widgets/
├── services/
```

Do not create services for a single API call.

------------------------------------------------------------------------

# Core Directories

Always search these folders before creating new code.

## Widgets

`lib/core/widgets`

Reuse existing widgets whenever possible.

## Utilities

`lib/core/utils`

Reuse helpers before creating new helpers.

## Localization

`lib/core/localization`

Every user-facing string must be localized.

## API Client

`lib/core/api/api_client/api_client.dart`

Never create another API client.

## Logger

`lib/core/logger/app_logger.dart`

Use AppLogger for all logging.

Never use:

-   print()
-   debugPrint()

------------------------------------------------------------------------

# Controller Rules

Controllers are the single source of truth.

Controllers own:

-   Business logic
-   API execution
-   Loading state
-   Error handling
-   Refresh
-   Retry
-   Pagination
-   Search
-   Navigation decisions

Controllers extend GetxController.

Widgets never execute APIs.

------------------------------------------------------------------------

# Service Rules

Create services only when:

-   Feature has multiple APIs
-   Shared API methods are needed
-   Networking logic becomes large

Services should only:

-   Call APIs
-   Parse responses
-   Return data

Services never:

-   Navigate
-   Show EasyLoading
-   Store UI state
-   Own business logic

------------------------------------------------------------------------

# UI Rules

Prefer StatelessWidget.

Use StatefulWidget only when Flutter framework requires it.

UI responsibilities:

-   Render data
-   Call controller methods
-   Observe Rx state using Obx/GetX

Never place business logic inside widgets.

------------------------------------------------------------------------

# Navigation

Always use GetX.

Allowed:

-   Get.to()
-   Get.off()
-   Get.offAll()
-   Get.back()

Never use Navigator.

------------------------------------------------------------------------

# EasyLoading

Always use Flutter EasyLoading.

Every EasyLoading event should also be logged using AppLogger.

Example workflow:

1.  AppLogger.info()
2.  AppLogger.show()
3.  API execution
4.  AppLogger.success()/error()
5.  AppLogger.dismiss() or showError()

Never use SnackBar or ScaffoldMessenger.

------------------------------------------------------------------------

# Feature Development Rules

Every feature must remain self-contained.

Preferred structure:

``` text
feature_name/
├── controllers/
├── screens/
├── widgets/
└── services/ (only if multiple APIs exist)
```

Never place feature widgets inside core unless reusable across the app.

------------------------------------------------------------------------

# Controller Standards

Controllers are the single source of truth.

Controllers are responsible for:

-   API execution
-   Business logic
-   Validation
-   Search
-   Pagination
-   Refresh
-   Infinite scroll
-   Navigation
-   Loading state
-   Error state

Never move business logic into widgets.

Always extend:

``` dart
GetxController
```

Dispose:

-   Worker
-   Timer
-   StreamSubscription
-   ScrollController
-   TextEditingController
-   FocusNode
-   AnimationController (if owned)

inside `onClose()`.

------------------------------------------------------------------------

# Service Standards

Create `services/` only when:

-   2+ related APIs
-   Shared networking
-   Large API logic

Services may:

-   Use ApiClient
-   Parse response
-   Return raw or mapped data

Services must not:

-   Show EasyLoading
-   Call Get.to()
-   Access BuildContext
-   Store UI state

------------------------------------------------------------------------

# Screen Rules

Screens should orchestrate layout only.

Keep screens under 250 lines.

Extract sections into widgets:

``` text
widgets/
header.dart
body.dart
list.dart
item.dart
loading.dart
empty.dart
```

Avoid deeply nested widget trees.

------------------------------------------------------------------------

# Widget Standards

Widgets should have one responsibility.

Prefer:

-   const constructors
-   final fields
-   StatelessWidget

Split reusable UI into:

`lib/core/widgets`

Feature-specific widgets remain inside the feature.

Never duplicate widgets.

------------------------------------------------------------------------

# State Management

Use GetX only.

Use:

-   RxBool
-   RxInt
-   RxString
-   RxList
-   RxMap
-   Rxn

Wrap only the minimum widget with Obx.

Avoid nested Obx.

Never rebuild an entire page for one value.

------------------------------------------------------------------------

# Dependency Rules

Use Get.find() for existing dependencies.

Register dependencies once.

Avoid duplicate controller instances.

Never instantiate controllers inside build().

------------------------------------------------------------------------

# Core Reuse Policy

Before writing code, search:

-   lib/core/widgets
-   lib/core/utils
-   lib/core/localization
-   lib/core/api/api_client
-   lib/core/logger

Reuse before creating.

------------------------------------------------------------------------

# Naming Convention

Screens:

-   HomeScreen
-   ProfileScreen

Controllers:

-   HomeController
-   ProfileController

Services:

-   HomeService

Widgets:

-   ProfileHeader
-   FeedCard
-   UserAvatar

Methods:

-   fetchPosts()
-   refreshData()
-   deleteConversation()

Variables:

-   camelCase

Classes:

-   PascalCase

Constants:

-   lowerCamelCase or project convention.

------------------------------------------------------------------------

# Code Quality

Always:

-   Remove dead code
-   Remove unused imports
-   Remove commented code
-   Keep methods focused
-   Use meaningful names
-   Prefer composition over duplication

Never introduce unnecessary abstraction.

------------------------------------------------------------------------

# Networking & API Standards

All networking must use:

`lib/core/api/api_client/api_client.dart`

Never create another HTTP client.

Always reuse the existing authentication, interceptors, headers, and
request flow.

------------------------------------------------------------------------

# API Workflow

Preferred flow:

``` text
UI
 ↓
Controller
 ↓
Service (only if feature has multiple APIs)
 ↓
ApiClient
 ↓
Server
```

Widgets must never call APIs directly.

------------------------------------------------------------------------

# API Request Rules

Always:

-   Validate input before sending.
-   Handle loading state.
-   Catch exceptions.
-   Handle timeout.
-   Handle no internet.
-   Handle null responses.
-   Handle unexpected status codes.
-   Log request and response with AppLogger.

Never assume success.

------------------------------------------------------------------------

# AppLogger 
Typical workflow:

``` dart
AppLogger.info("Fetching posts");
AppLogger.show(status: LocaleKeys.loading.tr);

// API Call

AppLogger.success("Posts loaded");
AppLogger.dismiss();

// Error
AppLogger.error(error.toString());
AppLogger.showError(LocaleKeys.somethingWentWrong.tr);
```

Always dismiss loading in every success and failure path.

------------------------------------------------------------------------

# Error Handling

Handle:

-   200 Success
-   201 Created
-   400 Bad Request
-   401 Unauthorized
-   403 Forbidden
-   404 Not Found
-   409 Conflict
-   422 Validation Error
-   429 Too Many Requests
-   500 Internal Server Error
-   Network timeout
-   SocketException
-   Unknown exceptions

Never expose raw backend errors to users.

Show localized friendly messages.

------------------------------------------------------------------------

# Pagination

Use lazy loading.

Rules:

-   Prevent duplicate requests.
-   Track current page/cursor.
-   Track hasMore.
-   Prevent multiple simultaneous loads.
-   Preserve scroll position.
-   Append new data.
-   Never reload the entire list unnecessarily.

------------------------------------------------------------------------

# Infinite Scroll

Load more only near the bottom.

Avoid calling APIs repeatedly while scrolling.

Throttle repeated requests.

------------------------------------------------------------------------

# Refresh

Support pull-to-refresh where appropriate.

Refreshing should:

-   Reset pagination.
-   Clear stale data.
-   Preserve filters when possible.

------------------------------------------------------------------------

# Search

Debounce user input.

Avoid sending a request on every keystroke.

Cancel outdated searches when possible.

------------------------------------------------------------------------

# Caching

Reuse already-loaded data when appropriate.

Avoid duplicate API calls for identical requests.

Refresh only when data becomes stale or user explicitly refreshes.

------------------------------------------------------------------------

# API Response Rules

Always verify:

-   success flag
-   status code
-   null data
-   empty collections

Never trust response shape blindly.

------------------------------------------------------------------------

# File Uploads

Validate:

-   file exists
-   supported type
-   file size

Show upload progress when available.

Handle upload failures gracefully.

------------------------------------------------------------------------

# Download Rules

Validate download path.

Handle permission failures.

Prevent duplicate downloads.

------------------------------------------------------------------------

# Security

Never hardcode:

-   Tokens
-   Secrets
-   API keys

Never log sensitive information.

Mask tokens in logs.

------------------------------------------------------------------------

# Production Checklist

Before merging:

-   No duplicate requests
-   Proper loading handling
-   Localized messages
-   Logged requests/errors
-   Pagination tested
-   Refresh tested
-   Offline behavior considered
-   Existing API contracts unchanged

------------------------------------------------------------------------

# GetX Standards

Use GetX for:

-   State Management
-   Dependency Injection
-   Navigation

Never introduce Provider, Riverpod, Bloc, Cubit, or setState for
business state.

------------------------------------------------------------------------

# Controller Lifecycle

Prefer permanent controllers only when truly global.

Initialize work inside:

-   onInit()
-   onReady()

Release resources inside:

``` dart
@override
void onClose() {
  worker.dispose();
  scrollController.dispose();
  textController.dispose();
  focusNode.dispose();
  timer?.cancel();
  streamSubscription?.cancel();
  super.onClose();
}
```

Never leak resources.

------------------------------------------------------------------------

# Workers

Use Workers to react to Rx changes.

Supported:

-   ever()
-   once()
-   debounce()
-   interval()

Store every Worker.

Example:

``` dart
late Worker searchWorker;
```

Dispose every Worker in onClose().

Never create anonymous workers without disposal.

------------------------------------------------------------------------

# Dependency Injection

Register dependencies once.

Use:

``` dart
Get.put()
Get.lazyPut()
Get.find()
```

Prefer lazyPut() unless immediate initialization is required.

Avoid duplicate registrations.

------------------------------------------------------------------------

# Rx Rules

Use reactive variables only when UI must react.

Avoid making every variable Rx.

Prefer:

-   RxBool
-   RxInt
-   RxString
-   RxList
-   RxMap
-   Rxn`<T>`{=html}

Keep rebuild scope minimal.

------------------------------------------------------------------------

# Obx Optimization

Wrap only the widget that depends on reactive data.

Avoid:

-   Wrapping entire Scaffold
-   Nested Obx trees
-   Rebuilding large lists

Extract small widgets instead.

------------------------------------------------------------------------

# Scroll Management

Reuse ScrollController.

Implement infinite scrolling through controller.

Never trigger multiple pagination requests.

Preserve scroll position whenever possible.

------------------------------------------------------------------------

# Forms

Controllers manage:

-   validation
-   submission
-   loading
-   reset

Widgets display validation only.

------------------------------------------------------------------------

# Navigation

All navigation flows through GetX.

Do not pass unnecessary objects.

Prefer IDs over large model objects.

------------------------------------------------------------------------

# Communication

Controller-to-controller communication should use:

``` dart
Get.find<OtherController>()
```

Avoid tight coupling.

Never create circular dependencies.

------------------------------------------------------------------------

# Memory Safety

Always dispose:

-   Worker
-   Timer
-   AnimationController
-   StreamSubscription
-   TextEditingController
-   ScrollController
-   FocusNode

Never retain references after screen disposal.

------------------------------------------------------------------------

# Performance Checklist

Always:

-   const constructors
-   final fields
-   extracted widgets
-   minimal Rx
-   minimal Obx
-   controller-driven logic

Avoid unnecessary rebuilds.

------------------------------------------------------------------------

# UI & UX Standards

Every screen should feel modern, premium, fast, and consistent.

Prioritize:

-   Clean layouts
-   Smooth interactions
-   Readable typography
-   Consistent spacing
-   Minimal visual clutter

------------------------------------------------------------------------

# Responsive Design

Support:

-   Mobile
-   Tablet
-   Large screens

Avoid fixed sizes whenever possible.

Use responsive sizing already available in the project.

Test layouts with different screen sizes.

------------------------------------------------------------------------

# Design Consistency

Maintain consistent:

-   Border radius
-   Padding
-   Margin
-   Font sizes
-   Icon sizes
-   Colors
-   Elevation

Reuse design tokens from the project.

Never invent new design styles for a single screen.

------------------------------------------------------------------------

# Reusable Widgets

Before creating any widget, check:

-   lib/core/widgets/

If reusable:

Use it.

Otherwise:

Create reusable widgets if they can be shared across multiple features.

------------------------------------------------------------------------

# Widget Composition

Prefer:

    ProfileScreen
     ├── ProfileHeader
     ├── ProfileStats
     ├── ProfileTabs
     ├── ProfilePosts
     └── BottomActions

Avoid giant build methods.

------------------------------------------------------------------------

# Animations

Animations should be:

-   Fast
-   Natural
-   Meaningful

Avoid excessive animations.

Use lightweight Flutter animations.

Never animate everything.

------------------------------------------------------------------------

# Loading States

Never leave blank screens.

Use:

-   EasyLoading for global loading
-   Skeleton loaders
-   Placeholder widgets
-   Progress indicators where appropriate

------------------------------------------------------------------------

# Empty States

Provide meaningful empty states.

Include:

-   Icon
-   Message
-   Optional action

Never show an empty white screen.

------------------------------------------------------------------------

# Error States

Errors should:

-   Explain the issue
-   Offer retry
-   Be localized

Never expose raw API errors.

------------------------------------------------------------------------

# Images

Use existing image widgets.

Support:

-   Placeholder
-   Error widget
-   Caching
-   Proper fit

Avoid layout shifts while images load.

## Network Image Caching Standard

Remote images must use the project’s centralized cached-network image widget or image service. Do not use a plain uncached network image throughout feature screens when the same image can be reused.

```text
Image URL received
  ↓
Normalize stable URL/cache key
  ↓
Check memory/disk cache
  ├─ Hit → render cached image
  └─ Miss → fetch once → decode at display size → store cache → render
       ↓
Failure → show placeholder/error/retry without infinite refetching
```

Rules:

- Search `lib/core/widgets`, `lib/core/utils`, and existing image services before creating a new image widget.
- Prefer an existing approved package such as `cached_network_image` only if it is already installed or its dependency cost has been reviewed; never add multiple image-cache packages.
- Configure stable cache keys, memory/disk limits, placeholder, error, retry, and expiration behavior in one central place.
- Do not download the same URL repeatedly because a widget rebuilds. Keep URLs stable and avoid generating changing query parameters unnecessarily.
- Use `memCacheWidth`/`memCacheHeight`, `cacheWidth`/`cacheHeight`, thumbnails, or server resizing when the displayed size is smaller than the source image.
- Do not decode a 4K image for a 48-pixel avatar. Match decode size to the largest realistic display size while preserving quality.
- Reuse cached thumbnails for lists, feeds, stories, maps, and chat; load full-resolution media only for detail or zoom flows.
- Use stable keys and avoid rebuilding entire image-heavy lists when one item changes.
- Cancel or ignore stale image requests when list items are recycled or screens are disposed.
- Do not cache private, expiring, signed, or sensitive images beyond the provider’s allowed lifetime; include authorization safely and never place secrets in URLs or logs.
- Provide offline behavior from cache where appropriate, but never present stale private content without the correct authorization policy.
- Evict or invalidate cache entries after user logout, account switch, content deletion, permission change, or known URL/version change.
- Test cold cache, warm cache, offline mode, failed image, expired URL, large image, rapid scrolling, memory pressure, and logout/account switching.

The goal is fewer network requests, lower decode memory, stable scrolling, and predictable failure behavior—not blindly caching every response forever.

------------------------------------------------------------------------

# Lists

Prefer:

-   ListView.builder
-   GridView.builder
-   SliverList
-   SliverGrid

Avoid large static children lists.

------------------------------------------------------------------------

# Bottom Sheets

Reuse existing bottom sheet components.

Keep actions grouped and intuitive.

------------------------------------------------------------------------

# Dialogs

Reuse common dialogs from core widgets.

Dialogs should:

-   Be concise
-   Have clear actions
-   Support localization

------------------------------------------------------------------------

# Accessibility

Support:

-   Large text
-   Screen readers
-   Proper tap targets
-   Color contrast

Avoid tiny buttons or unreadable text.

------------------------------------------------------------------------

# Theme

Always use project theme.

Never hardcode:

-   Colors
-   Text styles
-   Radius

Use existing theme and constants.

------------------------------------------------------------------------

# Typography

Maintain hierarchy:

-   Heading
-   Subtitle
-   Body
-   Caption

Never mix random font sizes.

------------------------------------------------------------------------

# UX Checklist

Every screen should:

-   Load quickly
-   Scroll smoothly
-   Show loading state
-   Handle empty state
-   Handle error state
-   Preserve state when possible
-   Feel responsive

------------------------------------------------------------------------

# Production UI Checklist

Before finishing:

-   Responsive
-   Localized
-   Reusable widgets
-   No overflow
-   No pixel overflow warnings
-   Smooth scrolling
-   Consistent spacing
-   Premium appearance

------------------------------------------------------------------------

# Performance Standards

Performance is mandatory.

Always:

-   Prefer const constructors.
-   Keep rebuild scope minimal.
-   Extract reusable widgets.
-   Use lazy loading.
-   Paginate large lists.
-   Cache expensive computations.
-   Dispose resources correctly.

Never optimize by changing business behavior.

------------------------------------------------------------------------

# Socket & Realtime

Existing socket behavior must remain unchanged.

Always:

-   Reuse existing socket manager.
-   Log socket events using AppLogger.
-   Handle reconnects gracefully.
-   Prevent duplicate listeners.
-   Remove listeners on dispose.
-   Handle offline state.

Never emit duplicate events.

------------------------------------------------------------------------

# Memory Management

Dispose every:

-   Worker
-   Timer
-   StreamSubscription
-   ScrollController
-   TextEditingController
-   FocusNode
-   AnimationController

Never retain screen references after disposal.

------------------------------------------------------------------------

# Refactoring Rules

When refactoring:

-   Preserve API contracts.
-   Preserve method signatures unless requested.
-   Preserve navigation.
-   Preserve localization.
-   Preserve UX.

Refactor only to improve readability, maintainability or performance.

------------------------------------------------------------------------

# Existing Code Protection

Never break:

-   APIs
-   Socket protocol
-   Existing features
-   Routing
-   Localization
-   Authentication
-   Permissions

Backward compatibility is required.

------------------------------------------------------------------------

# Security

Never hardcode:

-   Tokens
-   Secrets
-   API Keys

Never expose sensitive data in logs.

Validate user input before sending requests.

------------------------------------------------------------------------

# Code Review Checklist

Before completing work verify:

-   No analyzer warnings.
-   No unused imports.
-   No dead code.
-   No duplicated logic.
-   No hardcoded strings.
-   Proper localization.
-   AppLogger used.
-   EasyLoading handled.
-   Resources disposed.
-   Responsive UI.
-   Existing functionality preserved.

------------------------------------------------------------------------

# AI Workflow

Before writing code:

1.  Understand the request.
2.  Search existing implementation.
3.  Reuse widgets/utilities.
4.  Check localization.
5.  Check API client.
6.  Decide if a service is needed.
7.  Keep controller as source of truth.
8.  Optimize rebuilds.
9.  Validate edge cases.
10. Review before finishing.

Never rewrite working architecture unnecessarily.

------------------------------------------------------------------------

# Response Format

For implementation tasks provide:

1.  Folder changes
2.  Service changes (if any)
3.  Controller changes
4.  Screen changes
5.  Widget changes
6.  Brief implementation notes

Keep explanations concise.

------------------------------------------------------------------------

# Absolute Always

-   GetX
-   Feature-based architecture
-   Controllers own business logic
-   Services only for multi-API features
-   Existing ApiClient
-   AppLogger
-   Flutter EasyLoading
-   Localization
-   Responsive UI
-   Premium UX
-   Widget isolation
-   Production-ready code

------------------------------------------------------------------------

# Absolute Never

-   API calls in widgets
-   Business logic in UI
-   Duplicate widgets
-   Duplicate utilities
-   print()
-   debugPrint()
-   Navigator
-   SnackBar
-   ScaffoldMessenger
-   Hardcoded UI strings
-   Unnecessary packages
-   Unnecessary abstractions
-   Breaking existing behavior

------------------------------------------------------------------------

# Final Production Checklist

Before marking work complete ensure:

-   Clean architecture maintained
-   Minimal rebuilds
-   No memory leaks
-   Smooth scrolling
-   Optimized networking
-   Proper loading/error handling
-   Localized strings
-   Logging implemented
-   Existing functionality verified
-   Code is production ready

------------------------------------------------------------------------

# Flutter Performance Bible

Performance is a feature, not an afterthought.

Always optimize while preserving behavior.

------------------------------------------------------------------------

# Build Optimization

Always:

-   Use `const` constructors whenever possible.
-   Keep `build()` methods lightweight.
-   Extract reusable widgets instead of adding conditions.
-   Avoid expensive computations inside `build()`.

Never:

-   Execute API calls in `build()`.
-   Create controllers in `build()`.
-   Allocate heavy objects repeatedly.

------------------------------------------------------------------------

# Widget Rebuild Strategy

Minimize rebuild scope.

Prefer:

``` text
Scaffold
 ├── Static widgets
 └── Obx
      └── Small reactive widget
```

Avoid wrapping an entire screen with `Obx`.

------------------------------------------------------------------------

# Widget Isolation

One widget should have one responsibility.

Extract when:

-   Widget exceeds \~200 lines.
-   Multiple conditional branches exist.
-   UI is reused.
-   Separate state updates improve performance.

------------------------------------------------------------------------

# Lists

Always use:

-   ListView.builder
-   GridView.builder
-   SliverList
-   SliverGrid

Avoid large `children:` arrays.

Preserve scroll position.

Paginate large datasets.

------------------------------------------------------------------------

# Images

Reuse existing image widgets.

Always:

-   Show placeholders.
-   Show error widgets.
-   Cache network images if supported.
-   Use proper BoxFit.
-   Avoid loading full-resolution images unnecessarily.

------------------------------------------------------------------------

# Video

Avoid initializing multiple video players.

Dispose controllers immediately.

Pause playback when widgets leave the viewport.

Lazy initialize heavy media.

------------------------------------------------------------------------

# Async Operations

Never block the UI thread.

Await asynchronous work correctly.

Avoid nested async chains.

Cancel outdated requests when appropriate.

------------------------------------------------------------------------

# Scrolling

Optimize scrolling:

-   Lazy loading
-   Infinite scroll
-   Preserve position
-   Debounce load-more triggers

Avoid duplicate pagination requests.

------------------------------------------------------------------------

# Memory

Dispose:

-   Workers
-   Timers
-   Streams
-   Controllers
-   Animations
-   Focus nodes

Avoid retaining references after disposal.

------------------------------------------------------------------------

# Repaint Optimization

Reduce unnecessary repaints.

Extract frequently changing widgets.

Avoid rebuilding static layouts.

------------------------------------------------------------------------

# Network Optimization

Avoid duplicate requests.

Reuse loaded data.

Throttle rapid refreshes.

Batch requests when practical.

------------------------------------------------------------------------

# Rendering

Prefer simple widget trees.

Avoid deeply nested layouts.

Reduce unnecessary opacity, clipping, and layout passes.

------------------------------------------------------------------------

# CPU Optimization

Avoid:

-   Repeated parsing
-   Expensive loops in UI
-   Heavy synchronous computation

Move processing into controllers or isolates when truly expensive.

------------------------------------------------------------------------

# Isolates

Consider isolates only for CPU-intensive work such as:

-   Large JSON parsing
-   Image processing
-   Heavy data transformation

Do not use isolates for normal API calls.

------------------------------------------------------------------------

# Performance Review Checklist

Before completing work:

-   Minimal rebuilds
-   Widget isolation
-   Lazy loading
-   Pagination verified
-   No duplicate requests
-   No memory leaks
-   Controllers disposed
-   Workers disposed
-   Smooth scrolling
-   Stable frame rendering
-   Production-ready performance

------------------------------------------------------------------------

# AI Decision Framework

The AI must think before modifying code.

Never immediately generate code.

Always understand the existing architecture first.

------------------------------------------------------------------------

# Step 1 --- Understand the Request

Before writing code determine:

-   What is the actual problem?
-   Is it a bug, feature, optimization or refactor?
-   Which feature is affected?
-   Which files are involved?
-   What should remain unchanged?

Never make assumptions.

------------------------------------------------------------------------

# Step 2 --- Inspect Existing Code

Always inspect the existing implementation before creating anything new.

Search for:

-   Existing widgets
-   Existing controllers
-   Existing services
-   Existing utilities
-   Existing API methods
-   Existing localization keys

Reuse first.

------------------------------------------------------------------------

# Step 3 --- Preserve Architecture

Do not redesign the project unless explicitly requested.

Respect:

-   Folder structure
-   Naming conventions
-   Existing API contracts
-   Existing navigation
-   Existing socket flow

------------------------------------------------------------------------

# Step 4 --- Decide What to Create

Ask internally:

Can this be solved by:

-   Updating an existing widget?
-   Updating a controller?
-   Reusing a utility?
-   Extending an existing service?

Only create new files if required.

------------------------------------------------------------------------

# Widget Decision Rules

Before creating a widget ask:

Is a similar widget already available?

If yes:

Reuse it.

If not:

Determine whether it belongs in:

-   core/widgets
-   feature/widgets

Never duplicate UI.

------------------------------------------------------------------------

# Service Decision Rules

Create a service only if:

-   Multiple APIs exist
-   Shared networking exists
-   API logic becomes difficult to maintain

Otherwise keep API logic inside the controller.

------------------------------------------------------------------------

# Refactoring Decision Rules

Only refactor when it improves:

-   Readability
-   Maintainability
-   Performance
-   Reusability

Never refactor simply for personal preference.

------------------------------------------------------------------------

# Optimization Rules

Optimization must never change:

-   UX
-   Business logic
-   API behavior
-   Navigation
-   Socket protocol

Behavior preservation is mandatory.

------------------------------------------------------------------------

# Backward Compatibility

Every implementation should remain compatible with:

-   Existing routes
-   Existing APIs
-   Existing models
-   Existing controllers
-   Existing sockets

Do not introduce breaking changes.

------------------------------------------------------------------------

# Before Creating New Code

Check in this order:

1.  Existing widget
2.  Existing utility
3.  Existing service
4.  Existing controller
5.  Existing API
6.  Existing localization
7.  Existing theme

Reuse before creating.

------------------------------------------------------------------------

# Risk Assessment

Before making changes evaluate:

Low Risk

-   UI improvements
-   Widget extraction
-   Refactoring

Medium Risk

-   Controller changes
-   API updates
-   Navigation

High Risk

-   Authentication
-   Socket changes
-   Shared core utilities
-   Global architecture

Be extra cautious with high-risk changes.

------------------------------------------------------------------------

# Code Review Mindset

Think like a senior reviewer.

Ask:

-   Is this simpler?
-   Is this reusable?
-   Is this maintainable?
-   Is this performant?
-   Is this safe?
-   Does it follow project rules?

------------------------------------------------------------------------

# Completion Checklist

Before considering work complete:

-   Existing behavior preserved
-   Localization maintained
-   Logging implemented
-   EasyLoading handled
-   Performance reviewed
-   No duplicate code
-   No unnecessary files
-   Production ready

------------------------------------------------------------------------

# Raiz Project Intelligence

These rules override generic Flutter recommendations whenever they
conflict.

------------------------------------------------------------------------

# Core Project Structure

Always search and reuse before creating new code.

Priority order:

1.  lib/core/widgets
2.  lib/core/utils
3.  lib/core/localization
4.  lib/core/api/api_client
5.  lib/core/logger

Never duplicate existing implementations.

------------------------------------------------------------------------

# ApiClient Rules

Always use:

`lib/core/api/api_client/api_client.dart`

Never:

-   Create another HTTP client
-   Replace the existing authentication flow
-   Modify request/response contracts without instruction

Controllers or feature services should consume the existing ApiClient.

------------------------------------------------------------------------

# AppLogger Rules

Use AppLogger for:

-   API request start/end
-   API failures
-   Socket events
-   Pagination
-   Refresh
-   Uploads
-   Downloads
-   Unexpected exceptions

Never use:

-   print()
-   debugPrint()

Keep logs meaningful and concise.

------------------------------------------------------------------------

# EasyLoading Workflow

Standard flow:

1.  Log start with AppLogger.
2.  Show EasyLoading.
3.  Execute task.
4.  Log success or failure.
5.  Dismiss loading.
6.  Show localized success/error if appropriate.

Never leave EasyLoading visible after a failure.

------------------------------------------------------------------------

# Localization Rules

Every visible string must come from localization.

If a key is missing:

-   Add it to localization resources.
-   Reuse naming conventions.
-   Do not hardcode fallback text.

------------------------------------------------------------------------

# Feature Rules

Each feature should contain:

``` text
controllers/
screens/
widgets/
services/ (only when multiple APIs exist)
```

Keep feature code self-contained.

------------------------------------------------------------------------

# Widget Rules

Before creating a widget:

-   Search core widgets.
-   Search feature widgets.

If the widget is reusable across multiple features, place it in
`core/widgets`.

Otherwise keep it inside the feature.

------------------------------------------------------------------------

# Controller Rules

Controllers are responsible for:

-   UI state
-   Business logic
-   API orchestration
-   Pagination
-   Refresh
-   Navigation decisions

Keep controllers focused.

Split oversized controllers when responsibilities become unrelated.

------------------------------------------------------------------------

# Service Rules

Create services only when:

-   Multiple APIs belong to the feature.
-   API logic is reused.
-   Networking becomes difficult to maintain.

Never move business logic into services.

------------------------------------------------------------------------

# Optimization Priorities

Always optimize:

-   Rebuild scope
-   Widget tree depth
-   Network requests
-   Memory usage
-   Scroll performance

Never optimize by removing existing functionality.

------------------------------------------------------------------------

# Existing Code Policy

Prefer modifying existing files over creating duplicates.

Refactor instead of rewriting.

Maintain public APIs unless explicitly instructed otherwise.

------------------------------------------------------------------------

# AI Coding Workflow

Before coding:

-   Understand the task.
-   Inspect existing implementation.
-   Reuse existing components.
-   Decide if a service is required.
-   Preserve architecture.
-   Implement.
-   Review.
-   Optimize.
-   Verify behavior.

------------------------------------------------------------------------

# Final Project Checklist

Before completing any task ensure:

-   Existing functionality preserved.
-   Architecture respected.
-   No duplicate code.
-   AppLogger used.
-   EasyLoading handled correctly.
-   Localization complete.
-   Responsive UI verified.
-   Controllers cleaned up.
-   No memory leaks.
-   Production-ready implementation.

------------------------------------------------------------------------

# Golden Rules

Always:

-   Think before coding.
-   Reuse before creating.
-   Optimize before expanding.
-   Preserve before refactoring.
-   Build for production.

Never:

-   Break existing behavior.
-   Ignore project conventions.
-   Introduce unnecessary complexity.
-   Duplicate code.
-   Leave unfinished states.

------------------------------------------------------------------------

# Flutter Expert Patterns

This section defines advanced engineering practices for
production-quality Flutter development within the Raiz project.

------------------------------------------------------------------------

# Architecture Decision Matrix

Before implementing, choose the simplest architecture that satisfies the
requirement.

Priority:

1.  Update existing widget
2.  Update existing controller
3.  Add feature service (only if multiple APIs)
4.  Create reusable core widget
5.  Create new feature widget

Never introduce new architectural layers without explicit approval.

------------------------------------------------------------------------

# Feature Growth Strategy

As a feature grows:

-   Keep controllers focused.
-   Split UI into reusable widgets.
-   Move repeated API logic into feature services.
-   Avoid "God Controllers".

One controller should own one primary responsibility.

------------------------------------------------------------------------

# Async Programming

Always:

-   Use async/await.
-   Handle exceptions.
-   Cancel obsolete operations.
-   Avoid deeply nested Future chains.

Never block the UI thread.

------------------------------------------------------------------------

# Form Architecture

Controllers should manage:

-   Form validation
-   Submission
-   Loading state
-   Reset state

Widgets should only render fields and trigger controller actions.

Never place validation logic directly inside widgets.

------------------------------------------------------------------------

# Media Handling

Images:

-   Validate before upload.
-   Compress only if the project already supports it.
-   Display placeholders and error states.

Video:

-   Initialize lazily.
-   Dispose immediately when no longer visible.
-   Prevent background playback unless intentionally supported.

Files:

-   Validate type and size.
-   Handle permission failures gracefully.

------------------------------------------------------------------------

# Sliver & Scroll Patterns

For complex scrolling UIs, prefer:

-   CustomScrollView
-   SliverAppBar
-   SliverList
-   SliverGrid
-   SliverToBoxAdapter

Avoid nested scroll views unless required.

Maintain smooth scrolling and preserve scroll position.

------------------------------------------------------------------------

# Reusable Component Strategy

Before creating a component, ask:

-   Can it be reused in another feature?
-   Is a similar widget already available?
-   Does it belong in `core/widgets`?

If reusable across features, move it to the core layer.

------------------------------------------------------------------------

# Error Recovery

Controllers should support:

-   Retry
-   Refresh
-   Graceful fallback
-   Offline awareness (when applicable)

Never leave the user without feedback after an error.

------------------------------------------------------------------------

# Performance Monitoring

Continuously review:

-   Widget rebuild count
-   API frequency
-   Memory usage
-   Scroll performance
-   Animation smoothness

Optimize only after identifying the actual bottleneck.

------------------------------------------------------------------------

# Code Evolution

When extending existing features:

-   Prefer extending current implementations over rewriting.
-   Keep public APIs stable.
-   Preserve backward compatibility.
-   Refactor incrementally.

Avoid large, unnecessary rewrites.

------------------------------------------------------------------------

# Documentation

Write comments only when they add value.

Prefer self-explanatory code.

Document:

-   Complex algorithms
-   Non-obvious decisions
-   Public reusable utilities

Avoid redundant comments.

------------------------------------------------------------------------

# Senior Engineering Mindset

Before finalizing code, ask:

-   Is this the simplest solution?
-   Is it reusable?
-   Is it performant?
-   Does it follow project conventions?
-   Does it preserve existing behavior?
-   Would another engineer understand it quickly?

If any answer is "No", improve the implementation.

------------------------------------------------------------------------

# Expert Checklist

Every implementation should:

-   Follow feature architecture.
-   Use existing ApiClient.
-   Use AppLogger.
-   Use EasyLoading appropriately.
-   Localize all user-facing strings.
-   Avoid duplicate code.
-   Minimize rebuilds.
-   Dispose resources.
-   Remain production-ready.

------------------------------------------------------------------------

# AI Self-Review & Production Code Audit

This section defines the mandatory self-review process the AI must
perform before returning any implementation.

The AI must review its own work as if it were the final code reviewer.

Never skip this audit.

------------------------------------------------------------------------

# Phase 1 --- Requirement Verification

Confirm:

-   The user's request is fully addressed.
-   No requested functionality is missing.
-   Existing behavior is preserved.
-   Edge cases are considered.

If requirements are unclear, ask for clarification instead of making
assumptions.

------------------------------------------------------------------------

# Phase 2 --- Architecture Audit

Verify:

-   Feature-based architecture followed.
-   Controllers contain business logic.
-   Widgets remain presentation-only.
-   Services exist only when justified.
-   Existing project structure respected.

Reject unnecessary architectural changes.

------------------------------------------------------------------------

# Phase 3 --- Reuse Audit

Search mentally before creating:

-   Existing widgets
-   Existing utilities
-   Existing API methods
-   Existing controllers
-   Existing localization keys

If reusable code exists, prefer updating it instead of duplicating it.

------------------------------------------------------------------------

# Phase 4 --- Performance Audit

Verify:

-   Minimal widget rebuilds.
-   const constructors used where possible.
-   Widget isolation maintained.
-   Pagination preserved.
-   Lazy loading preserved.
-   No duplicate API requests.
-   No expensive work inside build().

------------------------------------------------------------------------

# Phase 5 --- Resource Audit

Confirm every owned resource is disposed:

-   Worker
-   Timer
-   StreamSubscription
-   ScrollController
-   TextEditingController
-   FocusNode
-   AnimationController

No memory leaks should remain.

------------------------------------------------------------------------

# Phase 6 --- Networking Audit

Verify:

-   Existing ApiClient used.
-   API contracts unchanged.
-   Loading handled correctly.
-   Errors handled gracefully.
-   Requests logged with AppLogger.
-   EasyLoading dismissed on all execution paths.

------------------------------------------------------------------------

# Phase 7 --- UI Audit

Check:

-   Responsive layout.
-   No overflow.
-   Localized strings only.
-   Theme reused.
-   Premium UX maintained.
-   Loading, empty, and error states implemented when appropriate.

------------------------------------------------------------------------

# Phase 8 --- Code Quality Audit

Ensure:

-   No dead code.
-   No commented-out code.
-   No unused imports.
-   No duplicated logic.
-   Clear naming.
-   Small focused methods.

------------------------------------------------------------------------

# Phase 9 --- Security Audit

Never expose:

-   Tokens
-   Secrets
-   API keys
-   Sensitive logs

Validate user input before network requests.

------------------------------------------------------------------------

# Phase 10 --- Final Production Audit

Before responding, verify:

-   Existing functionality preserved.
-   Architecture respected.
-   Controllers remain the source of truth.
-   Business logic is not inside widgets.
-   Services are justified.
-   AppLogger used.
-   EasyLoading used appropriately.
-   Localization complete.
-   No analyzer warnings introduced.
-   Production-ready quality achieved.

------------------------------------------------------------------------

# AI Response Rules

When returning code:

-   Keep explanations concise.
-   Explain architectural decisions only when useful.
-   Prefer modifying existing files over creating new ones.
-   Avoid unnecessary verbosity.
-   Focus on implementation quality.

------------------------------------------------------------------------

# Golden Engineering Principles

Always:

-   Think before coding.
-   Read before modifying.
-   Reuse before creating.
-   Optimize before expanding.
-   Preserve before refactoring.
-   Review before responding.

Never:

-   Guess project architecture.
-   Duplicate functionality.
-   Break backward compatibility.
-   Ignore existing conventions.
-   Trade correctness for speed.

------------------------------------------------------------------------

# Completion Statement

------------------------------------------------------------------------

# UNIVERSAL ARCHITECTURE EXTENSIONS

The following sections are mandatory additions to the project rules. They make payment, maps, isolates, animation, optimization, API, realtime, and quality decisions explicit instead of leaving them to individual implementation preference.

## 1. AI Pre-flight Decision Engine

Before changing code, execute this sequence:

```text
Understand outcome
  ↓
Read AGENTS.md and inspect project structure
  ↓
Search core widgets, utilities, services, models, routes, and dependencies
  ↓
Trace the existing feature flow and data contract
  ↓
Identify risks: compatibility, security, performance, UX, memory
  ↓
Choose reuse, refactor, or new implementation
  ↓
Implement the smallest maintainable change
  ↓
Run focused verification
  ↓
Review architecture, UX, security, resources, and performance
  ↓
Report changes, evidence, assumptions, and remaining risks
```

### New feature decision tree

```text
Need a feature?
  ↓
Search existing implementation
  ├─ Found → reuse
  └─ Not found
       ↓
Can existing code be generalized safely?
  ├─ Yes → refactor with tests → reuse
  └─ No → create feature-local code
```

### New widget decision tree

```text
Need a widget?
  ↓
Search lib/core/widgets
  ↓
Search feature widgets and the design system
  ↓
Suitable widget found?
  ├─ Yes → configure or compose it
  └─ No → can an existing widget be extended without feature leakage?
       ├─ Yes → extend it
       └─ No → create the smallest focused widget
```

Never create a new helper, service, API client, logger, state library, loading system, navigation system, or design component before searching for the existing project solution.

## 2. Universal Flutter Architecture

The standard flow is:

```text
Screen / Widget
  ↓ observes
GetX Controller
  ↓ coordinates
Service / Repository
  ↓ uses
ApiClient, SocketService, Storage, Platform SDK
  ↓ returns
Validated Model / Result
```

Responsibilities:

- **Screen/widget:** layout, semantics, rendering, and user intent callbacks.
- **Controller:** feature state, validation, orchestration, retry, pagination, and navigation decisions.
- **Service:** transport, SDK integration, parsing, and data-source operations.
- **Repository:** coordination between remote, local, cache, and synchronization policies when the feature needs that boundary.
- **Model/DTO:** typed data and serialization; never hide business side effects in models.
- **Core:** only truly cross-feature capabilities.

Do not put API calls, payment decisions, map calculations, socket parsing, business rules, or large transformations in `build()` methods.

## 3. Payment Architecture and Rules

Payment must be selected by product type and platform policy, not by convenience.

### Store billing is the default for in-app digital purchases

For a Flutter app distributed through the App Store or Google Play, the safe default is:

| Product | iOS/App Store | Android/Google Play |
|---|---|---|
| Digital feature, premium content, virtual currency, subscription, or in-app functionality | Apple In-App Purchase/StoreKit | Google Play Billing |
| Physical goods or service consumed outside the app | Approved external processor, Apple Pay, card flow, or provider SDK as applicable | Approved external processor, Google Pay, card flow, or provider SDK as applicable |
| Consumption-only reader/companion app | Follow the current platform rules; do not add an in-app external checkout casually | Follow the current Play policy; do not add a prohibited in-app payment path |

Do not use Stripe, PayPal, a custom card form, or a WebView to unlock digital content inside a store-distributed mobile app unless the applicable platform program, region, entitlement, and review rules explicitly permit that flow. A third-party processor is not a universal replacement for StoreKit or Google Play Billing.

Platform policies change by storefront, product category, country, app type, and legal program. Before implementation and before release, verify the current official requirements for the target countries and record the decision in an ADR. The default implementation must remain compliant if optional regional programs are unavailable.

### Platform-specific implementation policy

#### Apple

- Use StoreKit/In-App Purchase for digital goods, subscriptions, premium features, virtual currency, and content consumed in the app unless an applicable Apple rule or entitlement says otherwise.
- Configure products in App Store Connect and retrieve product metadata from StoreKit; do not hardcode user-facing price, currency, or subscription terms.
- Observe transactions at app launch, finish transactions correctly, support restore/sync behavior, and verify transactions through StoreKit and/or a trusted server.
- Use App Store Server Notifications and the App Store Server API where server-side subscription and entitlement synchronization is required.
- External purchase links or alternative purchase messaging are region- and entitlement-dependent. Never add them because another app has them; confirm eligibility and required entitlement first.
- For physical goods/services consumed outside the app, use an allowed external payment method rather than forcing StoreKit.

#### Google Play

- Use Google Play Billing for digital in-app features, subscriptions, virtual goods, and content unless a documented policy exception or enrolled alternative-billing program applies.
- Configure products in Play Console and use Play Billing product details for displayed pricing and terms.
- Verify purchases and subscription state on a trusted backend using the appropriate Play APIs; acknowledge/consume purchases according to product type and provider requirements.
- Alternative billing and external links are country-, program-, and eligibility-dependent. Enrollment, disclosures, reporting, service fees, and technical requirements may apply.
- For physical goods/services, peer-to-peer payments, and other documented exclusions, use a suitable external processor when permitted.
- Do not assume a US or regional legal exception applies to every country, app category, or product.

#### Third-party processors

Stripe or another processor may be appropriate for physical goods, real-world services, marketplace payments, or a platform-approved alternative flow. It must not be selected merely because its SDK is easy to add.

Before adding one, confirm:

1. product classification: digital versus physical/real-world;
2. App Store and Play policy for every target storefront;
3. provider availability, merchant country, currencies, tax, refund, and dispute support;
4. whether a native SDK, hosted checkout, or WebView is the approved integration;
5. server-side order creation, webhook verification, idempotency, and reconciliation;
6. PCI scope, privacy, consent, data retention, and secure logging;
7. app review instructions and test-account/demo-flow requirements;
8. a rollback path if the provider or regional program becomes unavailable.

### Payment security architecture

```text
User selects product
  ↓
App requests a server-created product/order identifier
  ↓
Platform billing or approved provider checkout
  ↓
App receives an untrusted transaction signal
  ↓
Backend verifies provider/platform transaction or webhook
  ↓
Backend applies entitlement/order state idempotently
  ↓
App fetches authoritative state
  ↓
UI displays purchased, pending, failed, or recovery state
```

The client must never decide entitlement from price, a redirect parameter, a local flag, or an unverified callback. Store only the minimum local state needed to resume the flow. Treat every callback as replayable and every network request as retryable unless proven otherwise.

Required security controls:

- no secret/private provider keys in Flutter, Android, iOS, assets, or remote config;
- server-created order/payment intent or platform product identifier;
- server-side signature/receipt/token verification;
- idempotency key per logical purchase attempt;
- webhook signature verification and duplicate-event handling;
- explicit authorization that the user may receive the entitlement;
- masked logs and redacted crash/analytics data;
- no raw card data handled by the app unless the provider and compliance scope explicitly require it;
- TLS, certificate/platform defaults, safe redirect/deep-link validation, and allowlisted checkout domains;
- pending-state recovery after process death, timeout, offline mode, and webhook delay;
- refund, cancellation, chargeback, and entitlement revocation handling.

### Payment release checklist

```text
Classify product
  ↓
Select platform billing or approved external method
  ↓
Verify region/program/entitlement
  ↓
Implement server authority and idempotency
  ↓
Implement restore/reconcile/pending/refund paths
  ↓
Test sandbox and failure cases
  ↓
Review privacy, PCI scope, logs, deep links, and app-store metadata
  ↓
Re-check current policies before submission
```

Official policy references to re-check before release:

- [Apple App Review Guidelines — 3.1 Payments](https://developer.apple.com/app-store/review/guidelines/)
- [Apple In-App Purchase documentation](https://developer.apple.com/documentation/storekit/in-app-purchase)
- [Apple App Store Server API and notifications](https://developer.apple.com/documentation/appstoreserverapi)
- [Google Play Payments policy](https://support.google.com/googleplay/android-developer/answer/9858738)
- [Google Play Billing overview](https://developer.android.com/google/play/billing)

These links are references, not a substitute for checking the current policy, storefront, and entitlement requirements at implementation time.

### In-app hosted checkout rule

When an external hosted checkout is permitted for the product type and storefront, it must open inside the application in a controlled WebView flow. Do not send the user to the device launcher, system browser, `url_launcher`, an unapproved browser package, or an arbitrary external intent for the payment journey.

```text
Backend creates approved checkout session
  ↓
App opens HTTPS checkout in an in-app WebView
  ↓
WebView allows only the approved payment domains
  ↓
User completes, cancels, or abandons checkout
  ↓
App receives a controlled return/deep-link result
  ↓
Backend webhook/API verifies final status
  ↓
App shows authoritative pending/success/failure state
```

In-app WebView rules:

- Use the existing approved WebView integration if the project already has one; search `pubspec.yaml` and existing payment code first.
- If no integration exists, evaluate the maintained official Flutter WebView option and its platform support before adding a dependency. Do not add multiple WebView packages.
- Never use `url_launcher` or an external browser for the payment flow when an approved in-app checkout is required.
- Allow only HTTPS and an explicit provider/return-domain allowlist; block arbitrary navigation, downloads, unknown schemes, and untrusted redirects.
- Do not inject secrets, card data, JavaScript bridges, or unrestricted native capabilities into the page.
- Handle back, close, cancel, timeout, app backgrounding, process death, network loss, and provider redirects without claiming success locally.
- Keep the WebView inside a dedicated payment screen with a visible close/cancel action and localized loading/error states.
- Do not use a WebView to bypass App Store or Play Billing requirements for digital goods. If policy requires native platform billing, use that instead.
- Verify payment completion on the backend after the WebView returns; a redirect URL is only a signal, never proof of payment.
- Clear or dispose the WebView and its listeners when the payment screen closes.

```text
What is being sold?
  ├─ Digital goods/features consumed inside the app
  │    └─ Check platform in-app purchase requirements first
  └─ Physical goods or real-world services
       └─ Evaluate an approved payment provider SDK
            ↓
Official native SDK available and supported?
  ├─ Yes → use it
  └─ No → evaluate approved hosted checkout
       ↓
Is WebView allowed for this transaction and platform?
  ├─ No/unclear → stop and verify current provider/platform rules
  └─ Yes → HTTPS-only allowlisted checkout with controlled return flow
       ↓
Client callback received
       ↓
Server verifies provider status/webhook
       ↓
Persist idempotent transaction state
       ↓
Show truthful pending/success/failure result
```

Mandatory payment rules:

- The backend owns amount, currency, order/payment-intent creation, authorization, capture, refund, entitlement, and final status.
- Never ship secret keys, private keys, webhook secrets, or unrestricted provider credentials in the app.
- Never trust a client-calculated amount, client callback, redirect query, or success screen as proof of settlement.
- Use official maintained SDKs when applicable; inspect existing dependencies before adding Stripe or another provider.
- WebView checkout must use HTTPS, an explicit domain allowlist, safe deep-link/return handling, cancellation support, and no silent amount or destination changes.
- Webhook processing must authenticate signatures, tolerate retries, deduplicate events, and be idempotent.
- Model at least `created`, `requiresAction`, `pending`, `succeeded`, `failed`, `canceled`, `refunded`, and `disputed` where the provider supports them.
- Prevent duplicate taps and duplicate charges with client state plus server idempotency keys.
- Payment logs must mask card data, tokens, customer secrets, personal data, and provider credentials.
- Reconcile delayed or interrupted payments after app restart; do not permanently mark an order failed because the app lost connectivity.
- Provide localized, actionable payment errors and a recovery path.
- Test success, cancellation, decline, timeout, duplicate request, webhook retry, delayed confirmation, refund, and app-killed scenarios.

Adding a payment package or WebView requires checking `pubspec.yaml`, backend contracts, platform requirements, and current official provider documentation first.

## 4. Google Maps and Location Architecture

Maps are a feature boundary, not a reason to put location logic in widgets.

```text
Location permission/state
  ↓
LocationService
  ↓
MapController / feature controller
  ↓
Validated markers, polylines, camera state
  ↓
Small reactive map widgets
```

Rules:

- Keep API keys and platform restrictions in platform configuration; never hardcode unrestricted secrets in Dart.
- Request permission only at the point of need, explain why, handle denied/permanently denied states, and provide settings recovery.
- Stop location streams when the feature is inactive unless background location is explicitly required and authorized.
- Keep marker, polyline, and camera state owned by the controller or map feature, not by repeated widget rebuilds.
- Reuse marker icons and avoid recreating every marker on every frame.
- Diff marker/polyline collections when practical; do not rebuild thousands of objects for one changed item.
- Perform route decoding, clustering, distance calculations, and heavy geometry off the UI isolate when measured workload justifies it.
- Debounce camera/search events and cancel stale requests.
- Handle no permission, no GPS, offline tiles, empty results, invalid coordinates, and provider errors.
- Never expose precise location in logs unless strictly required; redact or quantize where appropriate.
- Test lifecycle, permission changes, rotation/resume, empty maps, large marker sets, and network loss.

## 5. Isolate and Concurrency Rules

Isolates are for CPU-bound work, not a default wrapper around every API call.

```text
Is the work CPU-heavy on a representative payload?
  ├─ No → keep it on the main isolate
  └─ Yes → measure main-thread impact
       ↓
Can the work be safely transferred as simple data?
  ├─ No → simplify boundary or keep it local
  └─ Yes → use compute()/Isolate.run() or a managed isolate
       ↓
Verify lifecycle, cancellation, errors, ordering, and memory cost
```

Use isolates selectively for large JSON decoding/mapping, feed/story transformation, chat history sorting, media metadata, encryption/compression, route geometry, or other proven CPU-heavy work. Do not use isolates for ordinary network waiting, tiny payloads, UI objects, controllers, `BuildContext`, open sockets, or plugin objects that are not isolate-safe.

Rules:

- Entry points must be top-level or static and accept/return transferable data.
- Keep parsing pure: no navigation, logging UI, dependency lookup, or mutation of shared state.
- Treat isolate errors and cancellation as first-class failure paths.
- Do not create an isolate per small item; batch work when appropriate.
- Preserve response ordering and reject stale results before assigning state.
- Measure total latency, spawn/transfer overhead, memory, and battery impact.
- Dispose workers and subscriptions through the owning controller/service lifecycle.

## 6. Animation and Rendering Rules

Animation exists to communicate state, hierarchy, continuity, or feedback. It must never delay a critical action or hide an error.

```text
Does animation improve comprehension or feedback?
  ├─ No → do not add it
  └─ Yes → can an implicit/lightweight animation satisfy it?
       ├─ Yes → use the simplest animation
       └─ No → use an explicit controller with bounded lifecycle
            ↓
Measure rebuilds, raster time, memory, and reduced-motion behavior
```

Rules:

- Prefer `const` widgets and small reactive boundaries around animated content.
- Prefer `AnimatedContainer`, `AnimatedOpacity`, `TweenAnimationBuilder`, `Hero`, or other simple primitives before a custom controller.
- Use `AnimationController` only with a clear owner and guaranteed disposal.
- Do not start animations repeatedly from `build()`.
- Avoid animating expensive layout, large shadows, huge images, or entire page trees unnecessarily.
- Keep animation duration and curves consistent with the design system.
- Respect reduced-motion/accessibility preferences where supported.
- Avoid nested competing animations and infinite loops without an explicit stop condition.
- Use `RepaintBoundary` only when profiling shows an isolated repaint benefit.
- Test first frame, interrupted animation, route disposal, slow devices, and accessibility settings.

## 7. Optimization and Performance Rules

Optimization is evidence-driven.

```text
Performance concern reported
  ↓
Define user-visible metric and baseline
  ↓
Profile CPU / build / raster / memory / network / storage
  ↓
Locate root bottleneck
  ↓
Apply one bounded change
  ↓
Measure representative scenarios again
  ↓
Keep the change only if benefit exceeds complexity
```

Priority order:

1. Correctness and safe behavior.
2. Avoid unnecessary work.
3. Bound data, list length, retries, cache size, and concurrency.
4. Reduce rebuild scope and expensive layout/raster work.
5. Optimize network requests, payloads, caching, and pagination.
6. Move proven CPU-heavy transformations off the UI isolate.
7. Tune micro-allocations only after profiling.

Required practices:

- Use pagination or lazy loading for unbounded data.
- Debounce search and camera events; cancel stale requests.
- Keep `Obx`/reactive scopes as small as possible.
- Avoid work, object creation, and network calls in `build()`.
- Use stable keys where list identity requires them.
- Reuse image data, thumbnails, and decoded resources appropriately.
- Dispose controllers, timers, workers, streams, video players, map resources, and subscriptions.
- Prefer O(N) work with a small constant over clever structures whose memory or invalidation cost is unclear.
- Do not claim 60/120 FPS without profiling on representative hardware.

### Widget Weight and Narrowest-Widget Rule

Do not use a multi-purpose widget when a smaller, more specific widget expresses the same intent. This keeps the widget tree understandable and can avoid unnecessary layout, painting, or constraint work.

Use the narrowest equivalent:

| Intent | Prefer |
|---|---|
| Spacing | `SizedBox` or `Padding` |
| Alignment only | `Align` or `Center` |
| Constraints only | `ConstrainedBox` or `SizedBox` |
| Background color only | `ColoredBox` |
| Decoration only | `DecoratedBox` |
| Opacity only | `Opacity` or a suitable animated opacity widget |
| Safe area only | `SafeArea` |
| Layout direction only | `Row`, `Column`, `Wrap`, or `Flex` |

`Container` is not forbidden and is not automatically heavy. Use it when it genuinely combines multiple responsibilities such as padding, constraints, alignment, color, and decoration. Do not replace widgets mechanically without profiling or a readability benefit. The objective is a clear, minimal widget tree—not a benchmark-driven ban on valid Flutter primitives.

Avoid unnecessary `Builder`, nested `Container`s, nested `Opacity`, `IntrinsicHeight`/`IntrinsicWidth`, `LayoutBuilder` without a real constraint decision, and `shrinkWrap` on large scrolling lists. Extract reusable visual pieces, keep reactive scopes small, and do not create widgets merely to reduce a line count.

## 7.1 Isolate Setup and Usage Blueprint

Use an isolate only for measurable CPU-bound work that would otherwise cause UI jank. Network waiting belongs in asynchronous services; isolates do not make HTTP requests inherently faster.

### Isolate setup decision tree

```text
Is the operation CPU-bound?
  ├─ No → use normal async service code
  └─ Yes
       ↓
Is the payload large or the operation slow enough to affect frames?
  ├─ No → keep it on the main isolate
  └─ Yes
       ↓
Can input and output be represented as transferable data?
  ├─ No → redesign the boundary or keep it local
  └─ Yes → use compute() / Isolate.run()
       ↓
Define pure entry point, error behavior, stale-result policy, and lifecycle
       ↓
Measure before and after
```

### Preferred setup for one-shot work

Use a top-level or static pure function. Do not pass `BuildContext`, controllers, Rx objects, open sockets, plugin instances, `AnimationController`, or service locators into the isolate.

```dart
import 'dart:convert';
import 'package:flutter/foundation.dart';

class FeedParser {
  static List<FeedItem> parse(String rawJson) {
    final decoded = jsonDecode(rawJson) as List<dynamic>;
    return decoded
        .map((item) => FeedItem.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}

Future<List<FeedItem>> parseFeedInBackground(String rawJson) {
  return compute(FeedParser.parse, rawJson);
}
```

The entry point must be deterministic: input in, output out, no UI side effects. The model and parser must be safe for the selected isolate boundary. For very large or repeated workloads, use a deliberately managed worker isolate rather than spawning one isolate per item.

### Controller integration

```dart
class FeedController extends GetxController {
  final items = <FeedItem>[].obs;
  int _requestVersion = 0;

  Future<void> loadFeed(String rawJson) async {
    final requestVersion = ++_requestVersion;
    try {
      final parsed = await compute(FeedParser.parse, rawJson);
      if (requestVersion != _requestVersion || isClosed) return;
      items.assignAll(parsed);
    } catch (error, stackTrace) {
      AppLogger.error('Feed parsing failed', error: error, stackTrace: stackTrace);
    }
  }
}
```

For a managed isolate, the owner must retain the `Isolate`, `ReceivePort`, `SendPort`, subscriptions, and pending operation state. It must handle startup failure, message failure, cancellation, timeout, stale responses, and shutdown in `onClose()`. Never leave a worker, port, timer, or subscription alive after its feature is disposed.

### Isolate rules by workload

- **Feed/stories:** decode and map large response arrays only when profiling shows parsing affects frame time.
- **Chat:** parse or sort large history batches; keep socket ownership and UI state on the main isolate.
- **Maps:** calculate large route geometry, clustering, or distance matrices when necessary; keep map plugin calls on the supported isolate.
- **Media:** compress or transform files through an isolate/background mechanism only when the selected plugin supports it safely.
- **Payment:** never move provider SDK calls, secure checkout UI, web authentication, or transaction ownership into a custom isolate.

### Never use an isolate for

- ordinary API latency or a small JSON response;
- widget construction, `BuildContext`, navigation, or UI notifications;
- direct access to GetX controllers or reactive variables;
- platform channels/plugins that require the main isolate;
- work whose transfer and startup cost exceeds the computation itself.

Every isolate change must record the reason, measured baseline, payload boundary, error policy, disposal path, and verification result.

## 8. REST API and Model Blueprint

Required flow:

```text
Endpoint contract
  ↓
Typed request/response DTO or model
  ↓
ApiClient
  ↓
Feature service/repository
  ↓
GetX controller state
  ↓
Localized UI state
```

Rules:

- Keep base URL, endpoint paths, headers, timeout, auth, and retry policy centralized.
- Never create a second API client for convenience.
- Validate status codes, response shape, nullability, pagination, and error envelopes.
- Use typed models with safe `fromJson`/`toJson`; do not scatter raw map access through widgets.
- Keep transport exceptions distinguishable from validation, authorization, and business errors.
- Retry only safe/idempotent operations or use explicit idempotency.
- Log request metadata safely, never tokens or sensitive bodies.
- Add loading, empty, stale, retry, and offline behavior to controllers.

## 9. Socket and Realtime Blueprint

All socket behavior must flow through the existing socket abstraction.

- One ownership point for connect, reconnect, disconnect, authentication, and subscription.
- Explicit connection states: disconnected, connecting, connected, reconnecting, failed.
- Typed event parsing and version-aware payload handling.
- Backoff with bounded retries and no reconnect storm.
- Deduplication/order policy for events and reconnect replay.
- Heartbeat/timeout behavior where required.
- Stream subscriptions must be disposed by their owner.
- Do not close a shared singleton stream from a feature-specific controller.
- Never log raw private chat, auth tokens, or sensitive payloads.

## 10. Unified Logging and EasyLoading

`AppLogger` is the single project logging surface. Use it for developer diagnostics and the existing EasyLoading wrapper according to its established API.

Rules:

- Use structured severity and meaningful operation context.
- Pair user-facing loading/success/error feedback with correct dismissal/finalization.
- Never show a global loader for silent background refresh unless the UX requires it.
- Never leave a loader visible after timeout, cancellation, navigation, or exception.
- Never use `print`, `debugPrint`, ad hoc SnackBars, or competing notification systems.
- Redact tokens, payment details, location precision, private messages, and personal data.

## 11. Strict Code Quality and 250-Line Guidance

The preferred limit is fewer than 250 lines per Dart file. This is a warning boundary, not permission to split cohesive code into meaningless fragments.

When a file approaches the limit:

```text
Is the file mixing responsibilities?
  ├─ Yes → extract cohesive widgets/helpers/models/services
  └─ No → keep cohesion; document why the exception is safer
```

Never split only to satisfy a number. Never use the line cap to hide a God controller or move business logic into random files.

## 12. Feature and Module Index

Every applicable feature review should consider these modules:

1. Engineering philosophy and requirement clarity
2. Project lifecycle and acceptance criteria
3. Feature-isolated folder structure
4. MVC responsibility boundaries
5. Core reusable widgets
6. Utility and extension reuse
7. API client ownership
8. Endpoint and environment configuration
9. Request/response models
10. DTO and domain mapping
11. Service/repository boundaries
12. Controller state ownership
13. Dependency injection
14. Navigation and route guards
15. Authentication and session lifecycle
16. Authorization and role enforcement
17. Secure storage
18. Localization and formatting
19. Theme and design tokens
20. Responsive layout
21. Accessibility and semantics
22. Loading states
23. Empty states
24. Error and retry states
25. Offline and cache behavior
26. Pagination and infinite scroll
27. Debounced search
28. File upload/download
29. Media picking and compression
30. Image caching and memory
31. Video lifecycle
32. Stories and feed transformation
33. Chat and message ordering
34. Socket connection lifecycle
35. Push notification handling
36. Location and permissions
37. Google Maps markers, routes, and camera
38. Payment and transaction state
39. WebView safety and deep links
40. Isolates and CPU-bound work
41. Animation and frame performance
42. Rendering and rebuild scope
43. Logging and privacy-safe observability
44. Analytics and consent
45. Error reporting
46. Unit, widget, integration, and end-to-end tests
47. Security and dependency review
48. Migration, backward compatibility, and rollback
49. Architecture Decision Records and documentation
50. Code review, AI self-review, and production readiness

## 13. Mandatory Final Self-Review

Before returning any implementation, verify:

- Requirement and acceptance behavior are understood.
- Existing code and dependencies were searched.
- Reuse was preferred over duplication.
- GetX, ApiClient, AppLogger, EasyLoading, and navigation conventions remain consistent.
- Payment, map, socket, isolate, animation, and lifecycle rules were applied where relevant.
- No business logic was added to UI build methods.
- Loading, empty, error, retry, offline, cancellation, and duplicate-action states were considered.
- Security, privacy, permissions, accessibility, localization, and platform policy were considered.
- No resource, subscription, timer, controller, or worker leaks were introduced.
- Performance claims are measured or clearly labeled as expectations.
- Tests or focused verification were run, or the limitation is reported honestly.
- The final response states what changed, what was verified, and what remains.

## 14. Absolute Rules

Always search before creating. Always preserve existing contracts unless change is intended. Always verify sensitive outcomes on a trusted boundary. Always dispose resources. Always localize user-facing text. Always make failure recoverable where possible. Always report uncertainty.

Never invent APIs, backend fields, payment status, map capabilities, test results, or architecture. Never place secrets in client code. Never treat a client callback as payment settlement. Never use a WebView to bypass platform policy. Never optimize without a measured problem. Never add a dependency without reviewing its cost and exit path.

The implementation is considered complete only if it:

-   Solves the requested problem.
-   Preserves existing behavior.
-   Meets project architecture.
-   Passes all audits above.
-   Is suitable for direct production use.

------------------------------------------------------------------------

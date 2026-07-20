
Never prioritize cleaner code over breaking existing behavior.

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

The implementation is considered complete only if it:

-   Solves the requested problem.
-   Preserves existing behavior.
-   Meets project architecture.
-   Passes all audits above.
-   Is suitable for direct production use.

------------------------------------------------------------------------

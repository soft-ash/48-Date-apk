---
trigger: always_on
---

# Flutter Development Rules & Guidelines
## Senior Flutter Engineer Playbook (GetX + Performance + Scalable Architecture)

> **Version:** 1.0
> **Purpose:** A universal Flutter development standard that applies to every project regardless of size.
>
> Goal:
> - Clean Architecture
> - High Performance
> - Bug-Free Code
> - Premium UX
> - Smooth Animations
> - Easily Maintainable
> - Reusable Components
> - Scalable Structure

---

# Core Principles

These rules are mandatory.

## 1. UI NEVER Contains Business Logic

UI exists for only three things:

- Display data
- Receive user interaction
- Call controller methods

Nothing else.

### ❌ Never

- API call inside widget
- JSON parsing
- Validation logic
- Navigation decision
- Business calculations
- Timer management
- Permission handling
- File handling
- Database operation

Example

```dart
// BAD

ElevatedButton(
  onPressed: () async {
    final response = await http.get(...);
  },
);
```

---

### ✅ Correct

```dart
ElevatedButton(
  onPressed: controller.loadUser,
);
```

Controller

```dart
Future<void> loadUser() async {
   ...
}
```

---

# 2. Controller Owns Everything

Controller is the single source of truth.

Everything happens here.

Responsible for

- API
- Business logic
- Validation
- Loading state
- Error state
- Success state
- Navigation
- Local cache
- Socket
- Firebase
- Map
- Pagination
- Search
- Filtering
- Sorting
- Calculations

---

# 3. Model Only Stores Data

A model is NOT a service.

It is NOT a controller.

It does NOT contain business logic.

Only

```dart
fromJson()

toJson()

copyWith()
```

Nothing else.

---

# 4. Services Are Global

Things used everywhere belong inside reusable services.

Examples

```
ApiService

SocketService

LocationService

PermissionService

GoogleMapService

NotificationService

StorageService

ThemeService

LoggerService

EncryptionService

ConnectivityService

AnalyticsService
```

A service should never know about UI.

---

# 5. Widgets Are Small

Avoid 500 line widgets.

Instead

```
HomeScreen

↓

ProfileHeader

↓

ProfileStats

↓

ProfileButton

↓

RecentPosts

↓

PostCard
```

Everything reusable.

---

# Folder Rules

Every feature follows this structure.

```
feature/

    controller/

    model/

    screen/

        widgets/
```

Example

```
auth/

    controller/

        auth_controller.dart

    model/

        login_model.dart

    screen/

        login_screen.dart

        widgets/

            login_form.dart

            social_button.dart
```

---

# GetX Rules

Always use GetX.

Never mix multiple state management libraries.

Use

```
Get.put()

Get.find()

Obx()

Rx

Rxn

RxList

RxMap

Get.to()

Get.off()

Get.offAll()
```

Avoid StatefulWidget unless absolutely required by Flutter.

StatelessWidget is default.

---

# State Rules

Every async operation must expose state.

```
loading

success

error

empty
```

Example

```dart
final isLoading = false.obs;

final error = RxnString();

final users = <User>[].obs;
```

UI reacts automatically.

Never call

```
setState()
```

---

# API Rules

Only controller calls API.

Never

```
Widget

↓

API
```

Always

```
Widget

↓

Controller

↓

Repository (optional)

↓

ApiService

↓

Backend
```

---

# UI Responsibilities

UI may only

✔ show loading

✔ show error

✔ show data

✔ trigger event

Nothing else.

---

# Controller Responsibilities

Controller may

✔ fetch API

✔ validate

✔ calculate

✔ filter

✔ pagination

✔ sorting

✔ cache

✔ animation state

✔ timers

✔ navigation

✔ permissions

✔ sockets

---

# Animation Rules

Animations should never block UI.

Prefer

```
AnimatedContainer

AnimatedOpacity

AnimatedAlign

TweenAnimationBuilder

Hero

FadeTransition

ScaleTransition

SlideTransition

AnimationController
```

Avoid rebuilding the entire page.

Animate only what changes.

---

# Performance Rules

Never rebuild unnecessary widgets.

Bad

```
Entire screen rebuilds.
```

Good

```
Small Obx()

↓

Only button updates.
```

---

# Obx Rules

Keep Obx as small as possible.

Bad

```
Scaffold

↓

Obx
```

Good

```
Text

↓

Obx
```

Small rebuild area.

---

# Memory Rules

Dispose

```
TextEditingController

AnimationController

ScrollController

FocusNode

Timer

Worker

StreamSubscription
```

inside

```
onClose()
```

Never leak memory.

---

# ListView Rules

Always

```
ListView.builder()
```

Never

```
Column

↓

100 children
```

---

# Images

Use

```
CachedNetworkImage
```

Never

```
Image.network()
```

for production.

Always provide

- placeholder
- error widget

---

# Scroll Rules

Large pages

Use

```
CustomScrollView

SliverList

SliverGrid

SliverAppBar
```

Avoid nested scrolling.

---

# Constants

Never hardcode.

Wrong

```dart
padding: EdgeInsets.all(15)
```

Correct

```dart
AppSpacing.md
```

Same for

```
colors

radius

duration

strings

icons

assets

font sizes
```

---

# Responsive Design

Always support

- Mobile
- Tablet
- Landscape

Use

```
flutter_screenutil
```

or equivalent.

Never use magic numbers.

---

# Error Handling

Every API

```
try

catch

finally
```

Every exception handled.

Never crash app.

---

# Logging

Never use

```dart
print()
```

Use

```
LoggerService
```

Debug only.

Remove verbose logs in release.

---

# Loading

Never freeze UI.

Use

```
Skeleton

Shimmer

Progress

Placeholder
```

Not blank screens.

---

# Navigation

Navigation belongs to controller.

UI

```dart
controller.openProfile();
```

Controller

```dart
Get.to(ProfileScreen());
```

---

# Validation

Never inside TextField.

Controller validates.

UI only displays error.

---

# Dependency Injection

Global

```
Get.put()
```

Lazy

```
Get.lazyPut()
```

Retrieve

```
Get.find()
```

Avoid creating duplicate instances.

---

# Reusable Components

Create reusable widgets.

Examples

```
AppButton

AppTextField

AppDialog

AppBottomSheet

AppCard

AppImage

LoadingView

ErrorView

EmptyView

PaginationLoader

SearchBar

PrimaryAppBar
```

---

# Theme Rules

Never hardcode colors.

Everything inside

```
AppColors

AppTextStyle

AppTheme
```

---

# Asset Rules

Never use string path directly.

Wrong

```
assets/image.png
```

Correct

```
AppAssets.image
```

---

# Naming Convention

Controllers

```
HomeController
```

Models

```
UserModel
```

Widgets

```
ProfileCard
```

Services

```
ApiService
```

Extensions

```
DateExtension
```

Utilities

```
Formatter
```

---

# File Length

Ideal

```
150-250 lines
```

Maximum

```
350 lines
```

Split if larger.

---

# Business Logic Separation

Never mix these layers.

```
Presentation Layer

↓

Widgets

↓

Controller

↓

Repository (Optional)

↓

Service

↓

Backend
```

Flow

```
User Tap

↓

UI

↓

Controller

↓

Validation

↓

API

↓

Response

↓

Rx Variable

↓

Obx

↓

UI Updates
```

---

# UI Layer Checklist

Allowed

- Button
- Text
- Layout
- Icon
- Animation
- Gesture
- Obx
- Theme
- Responsive Layout

Forbidden

- API
- Validation
- JSON
- Permission
- Cache
- Socket
- Timer
- Navigation Logic
- Database

---

# Business Layer Checklist

Allowed

- API
- Cache
- Permission
- Firebase
- Maps
- Socket
- Validation
- Business Rules
- Parsing
- Calculations
- Navigation
- Search
- Pagination

Forbidden

- Widgets
- BuildContext dependency (unless unavoidable)
- UI rendering

---

# Premium UX Rules

Every interaction should feel polished.

Always include:

- Smooth page transitions
- Fade-in content
- Skeleton loading
- Pull-to-refresh
- Infinite scrolling
- Empty states
- Error recovery
- Optimistic UI updates where appropriate
- Haptic feedback for important actions
- Consistent spacing and typography
- Interactive feedback (hover, pressed, disabled states)
- Graceful offline handling
- Retry mechanisms for failed requests

---

# Performance Checklist

- Minimize widget rebuilds
- Use const constructors whenever possible
- Cache expensive computations
- Lazy load data
- Paginate large datasets
- Cache network images
- Avoid nested scroll views
- Dispose resources properly
- Prefer builder constructors
- Optimize animations to 60fps (or higher on supported devices)
- Avoid synchronous heavy work on the UI thread
- Use isolates (`compute`) for large JSON parsing or CPU-intensive tasks
- Debounce search input
- Throttle rapid user actions when needed

---

# Code Review Checklist

Before every commit, verify:

- [ ] No business logic in UI
- [ ] No API calls inside widgets
- [ ] No duplicated code
- [ ] Proper error handling
- [ ] Proper loading states
- [ ] Proper empty states
- [ ] No memory leaks
- [ ] Controllers cleaned up correctly
- [ ] Small, reusable widgets
- [ ] Responsive layout
- [ ] Smooth animations
- [ ] No unnecessary rebuilds
- [ ] Constants used instead of magic values
- [ ] Naming conventions followed
- [ ] Feature folder structure maintained
- [ ] Production-ready logging
- [ ] Null safety respected
- [ ] Clean, readable, maintainable code

---

# Golden Rule

> **A Flutter screen should only describe _what_ the user sees. The controller decides _what happens_. Services perform _how it happens_. Models define _what the data is_. Keeping these responsibilities separate creates fast, maintainable, testable, and scalable applications.**
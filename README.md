# Donny Maestro

Flutter mobile application with a feature-based structure, GetX state management, shared UI primitives, centralized routing, responsive sizing, and EasyLoading integration.

This README describes the current repository. Engineering rules for human and AI contributors live in:

- [`.agents/00_AI_OPERATING_SYSTEM.md`](.agents/00_AI_OPERATING_SYSTEM.md) — universal engineering reasoning and quality rules
- [`.agents/AGENTS.md`](.agents/AGENTS.md) — project-specific Flutter/GetX architecture, payment, maps, image caching, isolate, animation, and optimization rules

## Current status

The repository currently contains the application bootstrap and the initial onboarding/authentication flow:

```text
Splash → Welcome → Phone authentication → OTP
```

The route table currently contains:

| Route | Screen |
|---|---|
| `/splash` | `SplashScreen` |
| `/welcome` | `Welcome` |
| `/phone` | `PhoneScreen` |

The project does not currently contain the complete API, repository, payment, map, socket, or cached-network-image modules. Those modules must be added only when the corresponding feature requires them and after following the project rules.

## Technology

- Flutter and Dart
- GetX for state management and navigation
- Flutter EasyLoading for the existing loading/feedback integration
- `country_picker` for country selection
- `pinput` for OTP input
- Cupertino Icons
- Manrope font
- Android and iOS targets

Dependencies are defined in [`pubspec.yaml`](pubspec.yaml). Do not add another state-management, navigation, HTTP, loading, image-cache, WebView, or payment package without checking existing dependencies and documenting the reason.

## Repository structure

```text
donnymaestro/
├── android/                         # Android host project and platform resources
├── assets/
│   ├── icons/                       # App icons and splash artwork
│   └── images/                      # Onboarding and background images
├── ios/                             # iOS host project and platform resources
├── lib/
│   ├── main.dart                    # Application entry point
│   ├── donnymaestro.dart            # GetMaterialApp and EasyLoading bootstrap
│   ├── routes/
│   │   ├── app_routes.dart          # Named route constants
│   │   └── app_route.dart            # GetX route registrations
│   ├── core/
│   │   ├── constant/
│   │   │   ├── colors.dart           # Shared color tokens
│   │   │   ├── icons.dart            # Shared asset/icon paths
│   │   │   └── images.dart           # Shared image paths
│   │   ├── font/
│   │   │   ├── family/               # Bundled font files
│   │   │   └── style/                # Shared text styles
│   │   ├── logger/
│   │   │   └── logger.dart            # AppLogger integration
│   │   ├── utils/
│   │   │   ├── background.dart        # Shared screen/background composition
│   │   │   └── screen_utils.dart      # Responsive sizing helpers
│   │   └── widgets/                  # Reusable UI primitives
│   │       ├── custom_avatar.dart
│   │       ├── custom_button.dart
│   │       ├── custom_input_field.dart
│   │       ├── custom_toggle.dart
│   │       └── fade_in_up.dart
│   └── features/
│       ├── splash/
│       │   ├── controllers/splash_controller.dart
│       │   └── screens/splash_screen.dart
│       ├── welcome/
│       │   ├── controller/welcome_controller.dart
│       │   └── screen/welcome.dart
│       └── auth/
│           ├── phone/
│           │   ├── controller/phone_controller.dart
│           │   ├── screen/phone_screen.dart
│           │   └── widgets/
│           └── otp/
│               ├── controller/otp_controller.dart
│               ├── screen/otp_screen.dart
│               └── widgets/
├── analysis_options.yaml             # Dart analysis/lint configuration
├── pubspec.yaml                      # Dependencies, assets, fonts, app metadata
└── README.md
```

## Feature structure for new work

New features belong under `lib/features/<feature_name>/` and remain self-contained:

```text
lib/features/<feature_name>/
├── controllers/                      # GetxController state and orchestration
├── models/                           # Typed models and serialization
├── screens/                          # Screen-level layout orchestration
├── widgets/                          # Feature-only UI components
└── services/                         # Only when multiple/shared APIs require it
```

The existing authentication folders use singular names (`controller`, `screen`). Preserve an existing feature’s convention when modifying it; use the plural skeleton for newly created features unless the surrounding project is migrated deliberately.

### Responsibility boundaries

- Screens and widgets render state and forward user intent.
- Controllers own feature state, validation, loading, retry, pagination, and navigation decisions.
- Services call APIs or platform SDKs, parse data, and return results.
- Models represent typed data and must not perform UI side effects.
- Core code is shared only when it is genuinely reusable across features.

Widgets must not execute APIs, own business rules, or create duplicate global services.

## Application bootstrap

`lib/main.dart` starts `Donnymaestro`.

`lib/donnymaestro.dart` currently:

- creates `GetMaterialApp`;
- sets the initial route to `/splash`;
- registers `AppPages.pages`;
- initializes `AppScreenUtil` through the app builder;
- initializes Flutter EasyLoading.

Register new routes in both places:

1. Add a constant to `lib/routes/app_routes.dart`.
2. Add a matching `GetPage` to `lib/routes/app_route.dart`.

Use GetX navigation consistently. Do not introduce `Navigator` or a second routing system.

## Core reuse policy

Search before creating:

1. `lib/core/widgets`
2. `lib/core/utils`
3. `lib/core/constant`, `lib/core/font`, and `lib/core/logger`
4. Existing feature widgets/controllers/services
5. Existing dependencies in `pubspec.yaml`

Use the narrowest widget for the job. For example, prefer `SizedBox` for spacing, `Padding` for padding, `Align` for alignment, `ColoredBox` for a color-only background, and `DecoratedBox` for decoration-only work. `Container` is allowed when it combines multiple layout responsibilities; it is not banned or inherently heavy.

## Networking and image loading

When networking is introduced, use one centralized API client and feature services/repositories. Do not create ad hoc clients inside widgets or controllers.

Remote images must use a centralized cached-network image widget/service. The implementation must provide:

- memory/disk caching;
- stable cache keys;
- correctly sized decoding;
- placeholder and error states;
- controlled retry behavior;
- cache invalidation on logout, account switching, deletion, or URL/version change;
- safe handling for private or expiring image URLs.

Do not add multiple image-cache packages. Search the project first; if no solution exists, evaluate the dependency cost before adding one.

## Payment integration

Payment type must be classified before selecting a package:

- Digital features, subscriptions, virtual currency, and content consumed in the app use Apple StoreKit/In-App Purchase on iOS and Google Play Billing on Android by default.
- Physical goods and real-world services may use an approved third-party processor such as Stripe when platform policy permits.
- Regional alternative billing or external purchase links require current platform eligibility, enrollment, entitlement, and disclosure checks.

For an approved hosted checkout, keep the flow inside the app using one controlled, HTTPS-only WebView integration. Do not launch the external browser, launcher, `url_launcher`, or arbitrary intents for the payment journey.

Payment requirements:

- the backend creates the order/payment intent;
- the client never contains secret keys or decides final entitlement;
- WebView domains and return routes are allowlisted;
- redirects are treated as signals, not proof of payment;
- webhooks/provider APIs verify final status server-side;
- idempotency prevents duplicate charges;
- pending, cancellation, failure, refund, timeout, and app-restart recovery are supported;
- logs mask payment and personal data.

See the complete policy in [`.agents/AGENTS.md`](.agents/AGENTS.md) before implementing payment.

## Isolates and heavy processing

Use `compute()` or `Isolate.run()` only for measured CPU-heavy work such as large JSON decoding, feed/story transformations, chat history sorting, media processing, or map geometry calculations.

Do not use isolates for ordinary network waiting, small payloads, widget creation, `BuildContext`, GetX controllers, navigation, or unsupported plugin calls.

Every isolate implementation must define:

- a top-level/static pure entry function;
- transferable input/output data;
- error and timeout behavior;
- stale-result protection;
- cancellation or shutdown behavior;
- disposal of ports, workers, timers, and subscriptions;
- a measured reason for the added complexity.

Keep sockets, payment SDK calls, WebView UI, map plugin calls, and UI state on their supported owner/isolate.

## Animation and performance

Animations must communicate state or improve feedback. Prefer simple primitives such as `AnimatedOpacity`, `AnimatedContainer`, `AnimatedScale`, `TweenAnimationBuilder`, and `Hero` before creating an `AnimationController`.

Rules:

- never start animations from `build()`;
- dispose owned animation controllers;
- keep reactive rebuild scopes small;
- avoid animating large expensive trees unnecessarily;
- support reduced-motion behavior where applicable;
- profile before adding `RepaintBoundary` or complex custom painting;
- use `ListView.builder`, `GridView.builder`, or slivers for large collections;
- paginate and lazy-load unbounded data;
- debounce search/camera events and cancel stale requests;
- do not claim 60/120 FPS without representative profiling.

## Development workflow

```text
Understand requirement
  ↓
Inspect project rules and existing structure
  ↓
Search reusable code and dependencies
  ↓
Trace feature/data flow
  ↓
Plan smallest safe change
  ↓
Implement within existing conventions
  ↓
Format and analyze
  ↓
Run focused tests/checks
  ↓
Review UX, security, performance, memory, and architecture
  ↓
Report changes and verification
```

## Local development commands

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Use the project’s configured Flutter/Dart version. Do not regenerate platform files or upgrade dependencies as part of an unrelated feature.

## Quality checklist

Before merging a change, confirm:

- the requirement and acceptance behavior are clear;
- existing code and dependencies were searched;
- no duplicate API client, logger, state system, image cache, WebView, or payment integration was added;
- business logic is outside widget build methods;
- loading, empty, error, retry, offline, cancellation, and duplicate-action states are considered;
- resources are disposed correctly;
- user-facing strings follow the project localization strategy when localization is introduced;
- accessibility and responsive layout are considered;
- security and sensitive data are protected;
- relevant analysis/tests were run and reported honestly;
- the change remains understandable to the next maintainer.

## Engineering references

- [AI Operating System](.agents/00_AI_OPERATING_SYSTEM.md)
- [Project Agent Rules](.agents/AGENTS.md)
- [Flutter documentation](https://docs.flutter.dev/)
- [GetX package](https://pub.dev/packages/get)

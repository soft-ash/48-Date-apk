---
trigger: model_decision
---

---

# Isolate Rules (Heavy Task Processing)

Flutter has a single UI thread. Any CPU-intensive work performed on the main isolate can block rendering, causing dropped frames, laggy scrolling, frozen animations, and an unresponsive interface.

**Golden Rule:**

> If a task takes noticeable CPU time, move it off the UI thread.

Use isolates (or `compute()` for simple cases) for heavy processing.

## Always Use Isolates For

- Large JSON parsing
- Processing thousands of list items
- Image compression
- Image resizing
- Video processing
- File encryption/decryption
- ZIP extraction
- PDF generation
- CSV/Excel generation
- Large database exports/imports
- Data transformation
- Sorting very large collections
- Background calculations
- AI/ML inference (when applicable)
- Any computation that may block the UI

## Never Use Isolates For

- API requests (they are already asynchronous)
- Widget building
- UI updates
- Navigation
- Animations
- Small calculations
- Reading a few local preferences
- Lightweight JSON responses

## Decision Guide

```
Network Request
        │
        ├── Yes → async/await (No Isolate)
        │
        └── No
              │
              ├── Heavy CPU Task?
              │
              ├── Yes → Isolate / compute()
              │
              └── No → Execute Normally
```

## Example

### ❌ Bad

```dart
final users = jsonDecode(largeResponseBody);
```

This parses a large JSON payload on the UI thread and can freeze animations.

### ✅ Good

```dart
final users = await compute(parseUsers, largeResponseBody);
```

or create a dedicated isolate for long-running background work.

## Best Practices

- Keep isolates focused on CPU-intensive work.
- Pass only the required data between isolates.
- Avoid frequent isolate creation for tiny tasks.
- Reuse long-lived isolates when performing repeated heavy operations.
- Never manipulate UI directly from an isolate.
- Return processed results to the controller, then update Rx variables.

## Performance Rule

Whenever you notice:

- UI freezes
- Janky scrolling
- Animation stutters
- Frame drops
- Long synchronous loops

Ask yourself:

> "Can this run in an isolate instead?"

If the answer is yes, move it off the main isolate.


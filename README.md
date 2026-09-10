# Brewery Explorer

A two-screen iOS app (list + detail) built against the
[OpenBreweryDB](https://www.openbrewerydb.org/) API, built as a coding
challenge submission.

## Features

- Paginated brewery list, loading more as you scroll
- Brewery detail screen
- Retry-able error state — a failed request surfaces an error view with a
  "Try again" action rather than leaving the user stuck
- No server-side filter in this submission — see **Scope** below

## Architecture

Clean Architecture, dependencies pointing inward, with MVVM inside
Presentation:

    Presentation  →  Domain  ←  Data

- **Domain** (`BreweryApp/Domain`) — `Brewery` model, `BreweryRepository`
  protocol, `DomainError`. No dependency on Data or any networking type.
- **Data** (`BreweryApp/Data`) — `BreweryRepositoryImpl` implements
  `BreweryRepository`, talking to OpenBreweryDB through `NetworkService`,
  mapping `BreweryDTO` → `Brewery` via `BreweryMapper`, and translating
  `NetworkError` → `DomainError` at the boundary.
- **Presentation** (`BreweryApp/Presentation`) — SwiftUI views + MVVM
  ViewModels (`BreweryListViewModel`, `BreweryDetailViewModel`). Only ever
  sees Domain types, never DTOs.
- **App** (`BreweryApp/App`) — `Container` wires up the dependency graph
  and builds the root view.

## Scope

This challenge was scoped deliberately to fit its time box rather than to
match a production app. Delivered:

- List + detail screens, pagination, retry-able error state

Cut from the original plan (see `PLAN.md` for the full scope-change note):

- Server-side filter — descoped during polish (Milestone 4) in favor of
  finishing pagination, error handling, and test coverage properly.

## Testing

- **Domain**: untested by design — it's models + a protocol, no logic to
  verify.
- **Data**: `BreweryRepositoryImplTests` and `OpenBreweryDBEndpointTests`
  cover success, HTTP failure, and decoding-failure paths against a mocked
  `NetworkServiceProtocol`.
- **Presentation**: not covered by automated tests in this submission —
  ViewModel state-transition tests (loading/data/error/retry) were scoped
  out along with the filter feature.

Run tests via `Cmd+U` in Xcode, or:

```
xcodebuild test -project BreweryApp/BreweryApp.xcodeproj -scheme BreweryApp -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Requirements

- Xcode with iOS 26.5 SDK or later (see `project.pbxproj` for the exact
  deployment target)
- No API key needed — OpenBreweryDB is a public, unauthenticated API

## AI usage disclosure

Claude was used as a guidance and code-review partner throughout this
project — explaining Swift/SwiftUI/Foundation API behavior, reviewing code
for Clean Architecture violations, and helping reason through the
OpenBreweryDB response shape — not for generating the app implementation.
All application code was written by hand. See `CLAUDE.md` for the exact
operating mode given to the AI, and `PLAN.md` for how the project was
scoped and how it evolved.

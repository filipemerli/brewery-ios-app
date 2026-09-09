# Brewery Explorer — project plan

## Goal
A two-screen SwiftUI app (list + detail) against OpenBreweryDB, with a
retry-able error state and a server-side filter — scoped deliberately to
match the size of the challenge, not the size of a production app.

## Architecture
Clean layers, dependency pointing inward:

    Presentation  →  Domain  ←  Data

- **Domain** has zero framework imports. It's what stays untouched if the
  API ever changes shape.
- **Data** implements Domain's `BreweryRepository` protocol — it depends
  on Domain, never the other way around.
- **Presentation** (SwiftUI + MVVM) only ever sees Domain types, never DTOs.
- No design system yet. It gets added later as its own local Swift Package
  once the core flow works, so it never entangles app logic.

## Folder structure

    BreweryApp/
      App/
        BreweryAppApp.swift
        DependencyContainer.swift
      Domain/
        Brewery.swift
        BreweryFilter.swift
        BreweryRepository.swift
        DomainError.swift
      Data/
        BreweryDTO.swift
        BreweryMapper.swift
        OpenBreweryDBEndpoint.swift
        OpenBreweryDBClient.swift
      Presentation/
        ViewState.swift
        BreweryList/
          BreweryListView.swift
          BreweryListViewModel.swift
        BreweryDetail/
          BreweryDetailView.swift
          BreweryDetailViewModel.swift
      Tests/
        BreweryMapperTests.swift
        OpenBreweryDBClientTests.swift
        BreweryListViewModelTests.swift
        BreweryDetailViewModelTests.swift
    CLAUDE.md
    PLAN.md

## Milestones
1. **Domain + Data** — models, repository protocol, DTOs, API client,
   mapper, error mapping.
2. **Presentation** — list + detail views, ViewModels, loading/empty/
   error/retry states.
3. **Tests** — repository (mocked network), ViewModels (mock repository,
   state transitions, retry behavior).
4. **Polish + submission** — README, this plan finalized, AI usage
   disclosure written up plainly.

## Testing strategy
- Domain stays untested-by-necessity (it's just data + a protocol).
- Data layer: mock `URLProtocol`, cover success, HTTP failure, and
  malformed-JSON decoding paths.
- Presentation: inject a fake `BreweryRepository` conforming to the
  protocol — no real network, no mocking framework needed. Assert on
  `ViewState` transitions, including retry.

## AI usage disclosure
Claude was used as a guidance and debugging partner — explaining API
behavior, reviewing code for architecture violations, and helping parse
the OpenBreweryDB response shape — not for generating the implementation.
See `CLAUDE.md` in this folder for the exact operating mode used.

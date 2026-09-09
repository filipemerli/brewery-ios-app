//
//  BreweryListViewModel.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import Combine
import Foundation

final class BreweryListViewModel: ObservableObject {
    // MARK: Actions
    enum Action {
        case onAppear
        case retry
        case loadNextPage(Brewery)
    }

    // MARK: - Properties

    @Published private(set) var state: ViewState<BreweryListViewData> = .loading
    

    // MARK: - Dependencies (Injected following DIP)
    private let repository: BreweryRepository
    private let perPage = 10
    private let pageLimit = 10

    // MARK: Initializer
    init(repository: BreweryRepository) {
        self.repository = repository
    }

    // MARK: Public (Actions)

    func send(_ action: Action) {
        switch action {
        case .onAppear, .retry:
            fetchBreweryList(page: 1)
        case let .loadNextPage(brewery):
            loadNextPageIfNeeded(currentItem: brewery)
        }
    }

    // MARK: Private
    private func fetchBreweryList(page: Int) {
        Task {
            do {
                let result = try await repository.fetchBreweries(page: page, perPage: perPage)
                guard result.count > 0 else { return }
                state = .data(updateViewData(for: result))
            } catch let error as DomainError {
                state = .error(message: error.localizedDescription)
            } catch {
                state = .error(message: "Something went wrong")
            }
        }
    }

    private func loadNextPageIfNeeded(currentItem: Brewery) {
        guard case .data(var data) = state else { return }
        guard data.breweries.last == currentItem else { return }
        guard data.hasMorePages, !data.isLoadingNextPage else { return }
        guard data.currentPage < pageLimit else { return }

        data.isLoadingNextPage = true
        state = .data(data)
        fetchBreweryList(page: data.currentPage + 1)
    }

    private func updateViewData(for data: [Brewery]) -> BreweryListViewData {
        BreweryListViewData(breweries: data, currentPage: 1, isLoadingNextPage: false, hasMorePages: false)
    }
}

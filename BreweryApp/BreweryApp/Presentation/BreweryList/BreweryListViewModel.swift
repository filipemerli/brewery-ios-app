//
//  BreweryListViewModel.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import Combine
import Foundation

final class BreweryListViewModel: ObservableObject {
    // MARK: - Properties

    @Published private(set) var breweries: [Brewery] = []

    // MARK: - Dependencies (Injected following DIP)
    private let repository: BreweryRepository

    // MARK: Initializer
    init(repository: BreweryRepository) {
        self.repository = repository
        fetchBreweryList()
    }

    // MARK: Private
    private func fetchBreweryList() {
        Task {
            do {
                let result = try await repository.fetchBreweries(page: 1, perPage: 10)
                guard result.count > 0 else { return }
                breweries.removeAll()
                breweries = result
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

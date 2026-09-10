//
//  Container.swift
//  BreweryApp
//
//  Created by Filipe Merli on 10/09/2026.
//

import Foundation

final class Container {
    let service: NetworkServiceProtocol
    let repository: BreweryRepository

    init() {
        self.service = NetworkService()
        self.repository = BreweryRepositoryImpl(networkService: service)
    }

    func buildBreweryListView() -> BreweryListView<BreweryListViewModel> {
        let viewModel = BreweryListViewModel(repository: repository)
        return BreweryListView(viewModel: viewModel)
    }
}


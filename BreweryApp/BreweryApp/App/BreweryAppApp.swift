//
//  BreweryAppApp.swift
//  BreweryApp
//
//  Created by Filipe Merli on 08/09/2026.
//

import SwiftUI

@main
struct BreweryAppApp: App {
    let container = Container()

    var body: some Scene {
        WindowGroup {
            NavigationStack(root: container.buildBreweryListView)
        }
    }
}

final class Container {

    // MARK: Domain
    let service: NetworkServiceProtocol

    var repository: BreweryRepository?

    init() {
        self.service = NetworkService()
        resolveDataLayer()
    }

    private func resolveDataLayer() {
        guard let service = service as? NetworkService else { fatalError() }
        repository = BreweryRepositoryImpl(networkService: service)
    }


    func buildBreweryListView() -> BreweryListView<BreweryListViewModel> {
        guard let repository else { fatalError() }
        let viewModel = BreweryListViewModel(repository: repository)
        return BreweryListView(viewModel: viewModel)
    }
}

//
//  BreweryDetailViewModel.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import Combine
import Foundation

final class BreweryDetailViewModel: ObservableObject {
    // MARK: - Properties

    @Published private(set) var state: ViewState<Brewery> = .loading

    init(brewery: Brewery) {
        state = .data(brewery)
    }
}

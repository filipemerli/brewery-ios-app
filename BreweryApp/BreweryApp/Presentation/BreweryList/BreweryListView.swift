//
//  BreweryListView.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import SwiftUI

struct BreweryListView<ViewModel: BreweryListViewModel>: View {

    /// Doc about @StateObject usage https://developer.apple.com/documentation/swiftui/stateobject
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .navigationTitle("Brewery List")
    }

    // MARK: Components

    private var content: some View {
        List(viewModel.breweries, id: \.id) { brewery in
            Text("Name: \(brewery.name)")
        }
    }
}

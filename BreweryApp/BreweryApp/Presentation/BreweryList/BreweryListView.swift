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
        ViewStateView(
            state: viewModel.state,
            reloadActrion: { viewModel.send(.retry) }
        ) { data in
            List(data.breweries, id: \.id) { brewery in
                NavigationLink(value: brewery) {
                    breweryRow(brewery: brewery)
                        .onAppear { viewModel.send(.loadNextPage(brewery)) }
                }
            }
            .navigationDestination(for: Brewery.self) { brewery in
                BreweryDetailView(viewModel: BreweryDetailViewModel(brewery: brewery))
            }
            .navigationTitle("Brewery List")
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
    }

    private func breweryRow(brewery: Brewery) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(brewery.name)")
                .font(.title2.bold())
            HStack(spacing: 16) {
                Text("Type: \(brewery.breweryType ?? "")")
                    .font(.callout)
                    .fontWeight(.semibold)
                Text("City: \(brewery.city ?? "")")
                    .font(.callout)
                    .fontWeight(.semibold)
            }
        }
    }
}

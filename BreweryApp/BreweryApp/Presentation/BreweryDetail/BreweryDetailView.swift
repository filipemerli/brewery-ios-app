//
//  BreweryDetailView.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import SwiftUI

struct BreweryDetailView<ViewModel: BreweryDetailViewModel>: View {

    /// Doc about @StateObject usage https://developer.apple.com/documentation/swiftui/stateobject
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ViewStateView(
            state: viewModel.state,
            reloadActrion: nil
        ) { data in
            VStack(alignment: .leading, spacing: 12) {
                Text("Name: \(data.name)")
                    .font(FontTokens.detailsRow)
                if let typeText = data.breweryType {
                    Divider()
                    Text("Type: \(typeText)")
                        .font(FontTokens.detailsRow)
                }
                if let cityText = data.city {
                    Divider()
                    Text("City: \(cityText)")
                        .font(FontTokens.detailsRow)
                }
                if let addressText = data.address {
                    Divider()
                    Text("Address: \(addressText)")
                        .font(FontTokens.detailsRow)
                }
                if let postalCodeText = data.postalCode {
                    Divider()
                    Text("Postal Code: \(postalCodeText)")
                        .font(FontTokens.detailsRow)
                }
                if let phoneText = data.phone {
                    Divider()
                    Text("Phone: \(phoneText)")
                        .font(FontTokens.detailsRow)
                }
                Spacer()
            }
            .navigationTitle("Brewery Details")
        }
        .padding()
        .padding(.top, 48)
    }
}

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
                    .font(.title3)
                    .fontWeight(.semibold)
                if let typeText = data.breweryType {
                    Divider()
                    Text("Type: \(typeText)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                if let cityText = data.city {
                    Divider()
                    Text("City: \(cityText)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                if let addressText = data.address {
                    Divider()
                    Text("Address: \(addressText)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                if let postalCodeText = data.postalCode {
                    Divider()
                    Text("Postal Code: \(postalCodeText)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                if let phoneText = data.phone {
                    Divider()
                    Text("Phone: \(phoneText)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .navigationTitle("Brewery Details")
        }
        .padding()
        .padding(.top, 48)
    }
}

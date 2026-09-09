//
//  ContentView.swift
//  BreweryApp
//
//  Created by Filipe Merli on 08/09/2026.
//

import SwiftUI

struct ContentView: View {
    let networkService = NetworkService()
    let repository: BreweryRepository = BreweryRepositoryImpl(networkService: .init())
    @State var breweriesList: [Brewery] = []

    var body: some View {
        LazyVStack {
            ForEach(breweriesList, id: \.id) { brewery in
                HStack(spacing: 22) {
                    Text("Name: \(brewery.name)")
                }
            }
        }
        .padding()
        .onAppear {
            Task {
                do {
                    let dataModel: [Brewery] = try await repository.fetchBreweries(page: 1, perPage: 5)
                    breweriesList = dataModel
                } catch let error {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  BreweryApp
//
//  Created by Filipe Merli on 08/09/2026.
//

import SwiftUI

struct ContentView: View {
    let networkService: NetworkServiceProtocol = NetworkService()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            print("Alive")
            Task {
                do {
                    let domainData: [Dummy] = try await networkService.request(.list(page: 1, perPage: 15))
                    print(domainData)
                } catch let error {
                    print(error)
                }
            }
        }
    }

    struct Dummy: Decodable {
        let id: String
        let name: String
    }
}

#Preview {
    ContentView()
}

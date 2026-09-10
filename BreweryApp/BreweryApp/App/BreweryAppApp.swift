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

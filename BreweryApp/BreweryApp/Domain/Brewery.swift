//
//  Brewery.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import Foundation

struct Brewery: Equatable, Hashable {
    let id: String
    let name: String
    let city: String?
    let phone: String?
    let breweryType: String?
    let postalCode: String?
    let address: String?
}

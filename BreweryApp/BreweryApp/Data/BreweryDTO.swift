//
//  BreweryDTO.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import Foundation

internal struct BreweryDTO: Decodable {
    let id: String
    let name: String
    let brewery_type: String?
    let address_1: String?
    let city: String?
    let postal_code: String?
    let country: String?
    let phone: String?
    let state: String?
    let street: String?
}

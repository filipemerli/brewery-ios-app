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
    let breweryType: String?
    let address: String?
    let city: String?
    let postalCode: String?
    let country: String?
    let phone: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case breweryType = "brewery_type"
        case address = "address_1"
        case city
        case postalCode = "postal_code"
        case country
        case phone
    }
}

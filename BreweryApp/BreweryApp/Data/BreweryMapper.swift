//
//  BreweryMapper.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import Foundation

protocol BreweryMapperProtocol {
    func map(_ dto: BreweryDTO) throws -> Brewery
}

struct BreweryMapper: BreweryMapperProtocol {
    func map(_ dto: BreweryDTO) throws -> Brewery {
        Brewery(
            id: dto.id,
            name: dto.name,
            city: dto.city,
            phone: dto.phone,
            breweryType: dto.breweryType,
            postalCode: dto.postalCode,
            address: dto.address
        )
    }
}

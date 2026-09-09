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
        return Brewery(id: dto.id, name: dto.name)
    }
}

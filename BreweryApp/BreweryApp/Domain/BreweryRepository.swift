//
//  BreweryRepository.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import Foundation

protocol BreweryRepository {
    func fetchBreweries(page: Int, perPage: Int) async throws -> [Brewery]
    func fetchDetail(id: String) async throws -> Brewery
}

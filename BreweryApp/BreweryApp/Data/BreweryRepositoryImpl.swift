//
//  BreweryRepositoryImpl.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import Foundation

final class BreweryRepositoryImpl: BreweryRepository {
    
    private let networkService: NetworkServiceProtocol
    private let mapper: BreweryMapper

    init(networkService: NetworkServiceProtocol, mapper: BreweryMapper = BreweryMapper()) {
        self.networkService = networkService
        self.mapper = mapper
    }

    // MARK: BreweryRepository protocol

    func fetchBreweries(page: Int, perPage: Int) async throws -> [Brewery] {
        return try await requestBreweries(page: page, perPage: perPage)
    }

    func fetchDetail(id: String) async throws -> Brewery {
        return try await requestDetails(id: id)
    }

    // MARK: Private
    private func requestBreweries(page: Int, perPage: Int) async throws -> [Brewery] {
        let endpoint = OpenBreweryDBEndpoint.list(page: page, perPage: perPage)
        do {
            let dtos: [BreweryDTO] = try await networkService.request(endpoint)

            return try dtos.map(mapper.map)
        } catch let error as NetworkError {
            switch error {
            case .invalidResponse, .invalidURL:
                throw DomainError.unknown
            case .httpError(let code) where code == 404:
                throw DomainError.notFound
            case .httpError:
                throw DomainError.networkUnavailable
            case .decodingFailed:
                throw DomainError.decodingFailed
            }
        }
    }

    private func requestDetails(id: String) async throws -> Brewery {
        let endpoint = OpenBreweryDBEndpoint.detail(id: id)
        do {
            let dto: BreweryDTO = try await networkService.request(endpoint)

            return try mapper.map(dto)
        } catch let error as NetworkError {
            switch error {
            case .invalidResponse, .invalidURL:
                throw DomainError.unknown
            case .httpError(let code) where code == 404:
                throw DomainError.notFound
            case .httpError:
                throw DomainError.networkUnavailable
            case .decodingFailed:
                throw DomainError.decodingFailed
            }
        }
    }
}

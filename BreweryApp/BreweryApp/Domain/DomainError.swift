//
//  DomainError.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import Foundation

enum DomainError: Error {
    case networkUnavailable
    case notFound
    case decodingFailed
    case unknown

    init(from networkError: NetworkError) {
        switch networkError {
        case .invalidResponse, .invalidURL:
            self = .unknown
        case .httpError(let code) where code == 404:
            self = .notFound
        case .httpError:
            self = .networkUnavailable
        case .decodingFailed:
            self = .decodingFailed
        }
    }
}

//
//  NetworkError.swift
//  BreweryApp
//
//  Created by Filipe Merli on 08/09/2026.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case invalidURL
    case httpError(Int)
    case decodingFailed(Error)
}

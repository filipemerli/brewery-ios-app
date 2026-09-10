//
//  DomainError.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//
import Foundation

enum DomainError: Error, LocalizedError {
    case networkUnavailable
    case notFound
    case decodingFailed
    case unknown

    var errorDescription: String? {
        switch self {
        case .networkUnavailable: return "Please check your network connection."
        case .notFound: return "No data found."
        case .decodingFailed: return "Internal error!"
        case .unknown: return "Something went wrong"
        }
    }
}


//
//  Endpoint.swift
//  BreweryApp
//
//  Created by Filipe Merli on 08/09/2026.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem]? { get }
}

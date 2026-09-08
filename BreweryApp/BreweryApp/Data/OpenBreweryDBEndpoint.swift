//
//  OpenBreweryDBEndpoint.swift
//  BreweryApp
//
//  Created by Filipe Merli on 08/09/2026.
//

import Foundation

enum OpenBreweryDBEndpoint: Endpoint {

    case list(page: Int, perPage: Int)
    case detail(id: String)

    /// Note two: For security reasons, storing this information here is not an appropriate practice
    var baseURL: String { "https://api.openbrewerydb.org" }

    var path: String {
        switch self {
        case .list:
            return "/v1/breweries"
        case .detail(let id):
            return "/v1/breweries/\(id)"
        }
    }

    var method: String { "GET" }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .list(let page, let perPage):
            var items: [URLQueryItem] = []
            items.append(URLQueryItem(name: "page", value: "\(page)"))
            items.append(URLQueryItem(name: "per_page", value: "\(perPage)"))
            return items
        case .detail:
            return nil
        }
    }
}

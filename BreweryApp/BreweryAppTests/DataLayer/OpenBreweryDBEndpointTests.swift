//
//  OpenBreweryDBEndpointTests.swift
//  BreweryAppTests
//
//  Created by Filipe Merli on 09/09/2026.
//

import Foundation
import Testing
@testable import BreweryApp

struct OpenBreweryDBEndpointTests {

    private var sut: OpenBreweryDBEndpoint!

    @MainActor @Test mutating func testBreweryEndpointList() async throws {
        // Given
        let page = 1
        let perPage = 10
        let expectedQueryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)")
        ]

        // When
        sut = .list(page: page, perPage: perPage)

        // Then
        #expect(sut.baseURL == "https://api.openbrewerydb.org")
        #expect(sut.path == "/v1/breweries")
        #expect(sut.queryItems?.contains(expectedQueryItems) == true)
        #expect(sut.method == "GET")
    }

    @MainActor @Test mutating func testBreweryEndpointDetail() async throws {
        // Given
        let breweryId = "abcd-123"

        // When
        sut = .detail(id: breweryId)

        // Then
        #expect(sut.baseURL == "https://api.openbrewerydb.org")
        #expect(sut.path == "/v1/breweries/abcd-123")
        #expect(sut.method == "GET")
    }
}

//
//  BreweryRepositoryImplTests.swift
//  BreweryAppTests
//
//  Created by Filipe Merli on 09/09/2026.
//

import Foundation
import Testing

@testable import BreweryApp
struct BreweryRepositoryImplTests {

    private var sut: BreweryRepositoryImpl!
    private var networkService: NetworkServiceProtocol!

    init() {
        networkService = NetworkServiceMock()
        sut = BreweryRepositoryImpl(networkService: networkService)
    }

    @MainActor @Test func testSuccess() async throws {
        // Given
        // When
        let result = try await sut.fetchBreweries(page: 1, perPage: 10)

        // Then
        #expect(result.isEmpty == false)
    }

    @MainActor @Test func testErrorDeconding() async throws {
        // Given
        (networkService as! NetworkServiceMock).stubState = .errorDecoding

        // When
        do {
            _ = try await sut.fetchBreweries(page: 1, perPage: 10)
            Issue.record("Expected decoding error to be thrown")
        } catch {
            #expect(error is DomainError)
        }
    }

    @MainActor @Test func testErrorNetwork() async throws {
        // Given
        (networkService as! NetworkServiceMock).stubState = .errorNetwork

        // When
        do {
            _ = try await sut.fetchBreweries(page: 1, perPage: 10)
            Issue.record("Expected network error to be thrown")
        } catch {
            #expect(error is DomainError)
        }
    }

}

class NetworkServiceMock: NetworkServiceProtocol {
    enum StubState {
        case success
        case errorDecoding
        case errorNetwork
    }

    private let requestTimeout: TimeInterval = 10
    public var stubState: StubState = .success

    // MARK: Protocol
    func request<T>(_ endpoint: OpenBreweryDBEndpoint) async throws -> T where T : Decodable {
        let url = try buildURL(for: endpoint)
        return try await performRequest(endpoint: endpoint, url: url)
    }

    // MARK: Private - Single Responsibility Methods
    private func buildURL(for endpoint: OpenBreweryDBEndpoint) throws -> URL {
        switch endpoint {
        case .list(page: _, perPage: _):
            var components = URLComponents(string: endpoint.baseURL + endpoint.path)
            components?.queryItems = endpoint.queryItems
            guard let url = components?.url else {
                throw NetworkError.invalidURL
            }
            return url

        case .detail(id: _):
            guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
                throw NetworkError.invalidURL
            }
            return url
        }
    }

    private func performRequest<T: Decodable>(endpoint: Endpoint, url: URL) async throws -> T {
        switch stubState {
        case .success:
            let data = try Bundle.loadJSON("Payload")

            return try JSONDecoder().decode(T.self, from: data)

        case .errorDecoding:
            throw NetworkError.decodingFailed(DomainError.decodingFailed)

        case .errorNetwork:
            throw NetworkError.httpError(501)
        }
    }
}

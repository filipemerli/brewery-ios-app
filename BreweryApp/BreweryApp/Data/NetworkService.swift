//
//  NetworkService.swift
//  BreweryApp
//
//  Created by Filipe Merli on 08/09/2026.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: OpenBreweryDBEndpoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {

    private let session: URLSession
    private let decoder: JSONDecoder

    private let requestTimeout: TimeInterval = 10

    init(
        urlSession: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = urlSession
        self.decoder = decoder
    }

    // MARK: NetworkServiceProtocol
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
        let request = buildRequest(for: endpoint, with: url)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(httpResponse.statusCode)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }

    private func buildRequest(for endpoint: Endpoint, with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = requestTimeout
        return request
    }
}


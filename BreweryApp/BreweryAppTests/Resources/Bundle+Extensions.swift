//
//  Bundle+Extensions.swift
//  BreweryAppTests
//
//  Created by Filipe Merli on 09/09/2026.
//

import Foundation

extension Bundle {

    static var tests: Bundle {
        Bundle(for: BundleToken.self)
    }

    static func loadJSON(_ filename: String) throws -> Data {
        guard let url = tests.url(
            forResource: filename,
            withExtension: "json"
        ) else {
            throw TestError.fileNotFound(filename)
        }

        return try Data(contentsOf: url)
    }
}

private final class BundleToken {}

private enum TestError: Error {
    case fileNotFound(String)
}

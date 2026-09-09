//
//  BreweryMapperTests.swift
//  BreweryAppTests
//
//  Created by Filipe Merli on 09/09/2026.
//

import Foundation
import Testing

@testable import BreweryApp
struct BreweryMapperTests {

    private var sut: BreweryMapper

    init() {
        self.sut = BreweryMapper()
    }

//    maps all known DTO fields into domain Brewery
//    preserves optional values as nil when missing
//    returns correct breweryType, city, postalCode, etc.
//    does not crash on incomplete payloads
//    This is a high-signal unit test because it catches API-shape mismatches early.

    @MainActor @Test func testTransformsDtoToModel() async throws {
        // Given
        let data = try Bundle.loadJSON("Payload")
        let dtos = try JSONDecoder().decode([BreweryDTO].self, from: data)

        // When
        let result: [Brewery]

        do {
            result = try dtos.map(sut.map)
        } catch {
            Issue.record("Mapper failed to built DTO with error: \(error)")
            return
        }

        // Then
        #expect(result.isEmpty == false)
        #expect(result.last?.address == nil)
        #expect(result.first?.city == "Haines")
    }
}

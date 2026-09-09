//
//  BreweryListViewData.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import Foundation

struct BreweryListViewData: Equatable {
    var breweries: [Brewery]
    var currentPage: Int
    var isLoadingNextPage: Bool
    var hasMorePages: Bool
}

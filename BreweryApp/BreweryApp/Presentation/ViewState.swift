//
//  ViewState.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import Foundation

enum ViewState<T: Equatable>: Equatable {
    case data(T)
    case loading
    case error(message: String?)
}

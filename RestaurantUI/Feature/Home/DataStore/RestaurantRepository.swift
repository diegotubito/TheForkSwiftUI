//
//  RestaurantRepository.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation
typealias RestaurantResult = ResponseModel

protocol RestaurantRepositoryProtocol {
    func loadRestaurant() async throws -> RestaurantResult
}

class RestaurantRepository: ApiRequest, RestaurantRepositoryProtocol {
    func loadRestaurant() async throws -> RestaurantResult {
        try await apiCall(path: "TFTest/test.json", method: "GET")
    }
}

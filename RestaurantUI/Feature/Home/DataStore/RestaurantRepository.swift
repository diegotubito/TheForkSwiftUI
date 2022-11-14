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

class RestaurantRepositoryMock: ApiRequestMock, RestaurantRepositoryProtocol {
    func loadRestaurant() async throws -> RestaurantResult {
        try await apiCallMocked()
    }
}

class RestaurantRepositoryFactory {
    static func create() -> RestaurantRepositoryProtocol {
        let testing = ProcessInfo.processInfo.arguments.contains("-uiTest")
        return testing ? RestaurantRepositoryMock() : RestaurantRepository()
    }
}

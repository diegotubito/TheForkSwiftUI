//
//  RestaurantUseCase.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation

protocol RestaurantUseCaseProtocol {
    init(respository: RestaurantRepositoryProtocol)
    func loadRestaurant() async throws -> RestaurantResult
}

class RestaurantUseCase: RestaurantUseCaseProtocol {
    var repository: RestaurantRepositoryProtocol
    
    required init(respository: RestaurantRepositoryProtocol = RestaurantRepositoryFactory.create() ) {
        self.repository = respository
    }
    
    func loadRestaurant() async throws -> RestaurantResult {
        return try await repository.loadRestaurant()
    }
}

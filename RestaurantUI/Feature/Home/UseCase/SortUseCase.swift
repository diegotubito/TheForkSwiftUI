//
//  SortUseCase.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation

protocol SortUseCaseProtocol {
    func sortByName(input: [RestaurantModel]) -> [RestaurantModel]
    func sortByRating(input: [RestaurantModel]) -> [RestaurantModel]
}

class SortUseCase: SortUseCaseProtocol {
    func sortByName(input: [RestaurantModel]) -> [RestaurantModel] {
        input.sorted(by: {$0.name < $1.name})
    }
    
    func sortByRating(input: [RestaurantModel]) -> [RestaurantModel] {
        input.sorted(by: {$0.aggregateRatings.thefork.ratingValue > $1.aggregateRatings.thefork.ratingValue})
    }
}


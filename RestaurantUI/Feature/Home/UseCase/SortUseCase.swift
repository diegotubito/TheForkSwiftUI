//
//  SortUseCase.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation

protocol SortUseCaseProtocol {
    func sortByName(input: [Restaurant]) -> [Restaurant]
    func sortByRating(input: [Restaurant]) -> [Restaurant]
}

class SortUseCase: SortUseCaseProtocol {
    func sortByName(input: [Restaurant]) -> [Restaurant] {
        input.sorted(by: {$0.name < $1.name})
    }
    
    func sortByRating(input: [Restaurant]) -> [Restaurant] {
        input.sorted(by: {$0.aggregateRatings.thefork.ratingValue > $1.aggregateRatings.thefork.ratingValue})
    }
}


//
//  HomeViewModelTests.swift
//  RestaurantUnitTests
//
//  Created by David Gomez on 14/11/2022.
//

import XCTest
@testable import RestaurantUI

final class SortUseCaseTests: XCTestCase {
    func test_sort_by_name() {
        // Given
        let useCase = SortUseCase()
        
        // When
        let result = useCase.sortByName(input: getMockInput())
        
        // Then
        XCTAssertTrue(result[0].name == "Restaurant A")
    }
    
    func test_sort_by_rating() {
        // Given
        let useCase = SortUseCase()
        
        // When
        let result = useCase.sortByRating(input: getMockInput())
        
        // Then
        XCTAssertTrue(result[0].name == "Restaurant Z")
    }
    
    private func getMockInput() -> [Restaurant] {
        let restaurantA = Restaurant(name: "Restaurant A",
                                          uuid: "",
                                          address: Restaurant.Address(street: "",
                                                                           postalCode: "",
                                                                           locality: "",
                                                                           country: ""),
                                          aggregateRatings: Restaurant.AgregateRating(thefork: Restaurant.RatingDetail(ratingValue: 9.1,
                                                                                                                                 reviewCount: 50)))
        
        let restaurantB = Restaurant(name: "Restaurant Z",
                                          uuid: "",
                                          address: Restaurant.Address(street: "",
                                                                           postalCode: "",
                                                                           locality: "",
                                                                           country: ""),
                                          aggregateRatings: Restaurant.AgregateRating(thefork: Restaurant.RatingDetail(ratingValue: 9.5,
                                                                                                                                 reviewCount: 13)))
        return [restaurantA, restaurantB]
    }
}

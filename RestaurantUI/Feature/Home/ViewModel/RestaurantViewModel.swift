//
//  RestaurantViewModel.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation

class RestaurantViewModel: ObservableObject {
    var restaurantUseCase: RestaurantUseCaseProtocol
    var imageUseCase: ImageUseCaseProtocol
    var sortUseCase: SortUseCaseProtocol
    @Published var model: HomeModel
    
    init() {
        restaurantUseCase = RestaurantUseCase()
        imageUseCase = ImageUseCase()
        sortUseCase = SortUseCase()
        model = HomeModel(restaurants: [])
    }
    
    func loadRestaurants() async {
        do {
            let register = try await restaurantUseCase.loadRestaurant()
            DispatchQueue.main.async {
                self.model.restaurants = self.mapResponse(input: register.data)
                self.sortByName()
            }
        } catch {
            DispatchQueue.main.async {
                print(error.localizedDescription)
            }
        }
    }
    
    func mapResponse(input: [RestaurantModel]) -> [Restaurant] {
        var mappedList: [Restaurant] = []
        for restaurant in input {
            let new = Restaurant(name: restaurant.name, uuid: restaurant.uuid,
                                 address: Restaurant.Address(street: restaurant.address.street, postalCode: restaurant.address.postalCode, locality: restaurant.address.locality, country: restaurant.address.country),
                                 aggregateRatings: Restaurant.AgregateRating(thefork: Restaurant.RatingDetail(ratingValue: restaurant.aggregateRatings.thefork.ratingValue, reviewCount: restaurant.aggregateRatings.thefork.reviewCount)),
                                 mainPhoto: Restaurant.MainPhoto(source: restaurant.mainPhoto?.source ?? "", photo_612x344: restaurant.mainPhoto?.photo_612x344 ?? ""),
                                 imageState: .new)
            
            
            mappedList.append(new)
        }
        return mappedList
    }

    func sortByName() {
        model.restaurants = sortUseCase.sortByName(input: model.restaurants)
    }
    
    func sortByRating() {
        model.restaurants = sortUseCase.sortByRating(input: model.restaurants)
    }
}

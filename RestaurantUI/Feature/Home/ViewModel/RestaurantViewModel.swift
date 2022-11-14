//
//  RestaurantViewModel.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation

class RestaurantViewModel {
    var restaurantUseCase: RestaurantUseCaseProtocol
    
    init() {
        restaurantUseCase = RestaurantUseCase()
    }
    
    func loadRestaurants() async {
        do {
            let register = try await restaurantUseCase.loadRestaurant()
            for i in register.data {
                print(i.name)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

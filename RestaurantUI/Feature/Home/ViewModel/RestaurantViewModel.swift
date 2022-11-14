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
                self.getIsFavourite()
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
    
    func loadImage(index: Int) async {
        switch model.restaurants[index].imageState {
        case .new:
            guard let stringURL = model.restaurants[index].mainPhoto?.photo_612x344 else {
                model.restaurants[index].imageState = .failed
                DispatchQueue.main.async {
                    self.model.restaurants[index].imageData = nil
                }
                return
            }
            
            do {
                let imageData = try await imageUseCase.loadImage(url: stringURL)
                DispatchQueue.main.async {
                    self.model.restaurants[index].imageData = imageData
                    self.model.restaurants[index].imageState = .downloaded
                }
            } catch {
                self.model.restaurants[index].imageState = .failed
            }
        case .downloaded, .failed, .none:
            break
        }
    }
    
    func setFavourite(indexPath: IndexPath) {
        let uuid =  model.restaurants[indexPath.row].uuid
        let currentValue = UserDefaults.standard.object(forKey: uuid) as? Bool ?? false
        UserDefaults.standard.set(currentValue ? false : true, forKey: uuid)
        model.restaurants[indexPath.row].isFavourite = currentValue ? false : true
   //     self.onUpdatePhoto?(indexPath)
    }
    
    private func getIsFavourite() {
        for (index, restaurant) in model.restaurants.enumerated() {
            let currentValue = UserDefaults.standard.object(forKey: restaurant.uuid) as? Bool
            model.restaurants[index].isFavourite = currentValue
        }
    }
    
    func sortByName() {
 //       model.restaurants = sortUseCase.sortByName(input: model.restaurants)
 //       onUpdateTableViewList?()
    }
    
    func sortByRating() {
 //       model.restaurants = sortUseCase.sortByRating(input: model.restaurants)
 //       onUpdateTableViewList?()
    }
}

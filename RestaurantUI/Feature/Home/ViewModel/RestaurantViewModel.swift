//
//  RestaurantViewModel.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation

class RestaurantViewModel {
    var restaurantUseCase: RestaurantUseCaseProtocol
    var imageUseCase: ImageUseCaseProtocol
    var sortUseCase: SortUseCaseProtocol
    var model: HomeModel
    
    init() {
        restaurantUseCase = RestaurantUseCase()
        imageUseCase = ImageUseCase()
        sortUseCase = SortUseCase()
        model = HomeModel(restaurants: [])
    }
    
    func loadRestaurants() async {
        do {
            let register = try await restaurantUseCase.loadRestaurant()
            model.restaurants = register.data
            for (index, _) in self.model.restaurants.enumerated() {
                self.model.restaurants[index].imageState = .new
            }
            self.getIsFavourite()
            self.sortByName()
            for i in model.restaurants {
                print(i.name)
            }
            DispatchQueue.main.async {
                //self.onUpdateTableViewList?()
            }
        } catch {
            DispatchQueue.main.async {
                print(error.localizedDescription)
            }
        }
    }
    
    func loadImage(index: Int) async {
        print("loading image...")
        switch model.restaurants[index].imageState {
        case .new:
            guard let stringURL = model.restaurants[index].mainPhoto?.photo_612x344 else {
                model.restaurants[index].imageState = .failed
                //onUpdatePhoto?(indexPath)
                return
            }
            
            do {
                let imageData = try await imageUseCase.loadImage(url: stringURL)
                self.model.restaurants[index].imageData = imageData
                self.model.restaurants[index].imageState = .downloaded
               
                DispatchQueue.main.async {
                    // self.onUpdatePhoto?(indexPath)
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
        model.restaurants = sortUseCase.sortByName(input: model.restaurants)
 //       onUpdateTableViewList?()
    }
    
    func sortByRating() {
        model.restaurants = sortUseCase.sortByRating(input: model.restaurants)
 //       onUpdateTableViewList?()
    }
}

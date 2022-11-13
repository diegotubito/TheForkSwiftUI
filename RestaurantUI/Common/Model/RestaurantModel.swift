//
//  RestaurantModel.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation

struct ResponseModel: Decodable {
    var data: [RestaurantModel]
}

struct RestaurantModel: Decodable {
    var name: String
    var uuid: String
    var address: Address
    var aggregateRatings: AgregateRating
    var mainPhoto: MainPhoto?
    var imageState: ImageState?
    var imageData: Data?
    var isFavourite: Bool?
    
    enum ImageState: Decodable {
        case new, downloaded, failed
    }
    
    struct AgregateRating: Decodable {
        var thefork: RatingDetail
    }
    
    struct RatingDetail: Decodable {
        var ratingValue: Double
        var reviewCount: Int
    }
    
    struct Address: Decodable {
        var street: String
        var postalCode: String
        var locality: String
        var country: String
    }
    
    struct MainPhoto: Decodable {
        var source: String
        var photo_612x344: String
        
        enum CodingKeys: String, CodingKey {
            case source
            case photo_612x344 = "612x344"
        }
    }
}

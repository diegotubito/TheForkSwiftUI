//
//  ApiRequestError.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation

enum ApiRequestError: Equatable, Error, CustomStringConvertible {
    case notFound
    case imageNotFound
    case wrongUrl
    case serialize(identifier: String)
    case httpUrlResponseCast
    case unhandleError
    case backendError(message: String)
    
    var message: String {
        switch self {
        case .notFound:
            return "Not found"
        case .imageNotFound:
            return "Image not found."
        case .wrongUrl:
            return "Wrong URL"
        case .serialize(let identifier):
            return "Error serializing from object identifier \(identifier)"
        case .backendError(message: let message): return message
        case .httpUrlResponseCast:
            return "Could not cast HTTPUrlResponse"
        case .unhandleError:
            return "Unhandled error from backend"
        }
    }
    
    public var description: String {
        return "🧨⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽\nmessage: \(self.message)\n⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺"
    }
}


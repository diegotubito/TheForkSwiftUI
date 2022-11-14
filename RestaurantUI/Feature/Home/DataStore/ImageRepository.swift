//
//  ImageRepository.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation

typealias ImageResult = Data

struct ImageEntity {
    struct Request {
        var url: String
    }
}

protocol ImageRepositoryProtocol {
    func loadImage(request: ImageEntity.Request) async throws -> ImageResult
}

class ImageRepository: ApiRequest, ImageRepositoryProtocol {
    func loadImage(request: ImageEntity.Request) async throws -> ImageResult {
        return try await loadImageNoCache(stringUrl: request.url)
    }
}

class ImageRepositoryMock: ApiRequestMock, ImageRepositoryProtocol {
    func loadImage(request: ImageEntity.Request) async throws -> ImageResult {
        return try await loadImageMock()
    }
}

class ImageRepositoryFactory {
    static func create() -> ImageRepositoryProtocol {
        let testing = ProcessInfo.processInfo.arguments.contains("-uiTest")
        return testing ? ImageRepositoryMock() : ImageRepository()
    }
}

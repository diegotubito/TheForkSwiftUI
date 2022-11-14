//
//  ImageUseCase.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation

protocol ImageUseCaseProtocol {
    init(repository: ImageRepositoryProtocol)
    func loadImage(url: String) async throws -> Data
}

class ImageUseCase: ImageUseCaseProtocol {
    var repository: ImageRepositoryProtocol
    
    required init(repository: ImageRepositoryProtocol = ImageRepositoryFactory.create()) {
        self.repository = repository
    }
    
    func loadImage(url: String) async throws -> Data {
        let request = ImageEntity.Request(url: url)
        return try await repository.loadImage(request: request)
    }
}

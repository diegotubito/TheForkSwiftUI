//
//  ApiRequest.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation

@available(iOS 13.0.0, *)
open class ApiRequest {
    var session: URLSession
    var body: Data?
    var queryItems: [QueryModel] = []
    var headers: [String: String] = [:]
    var host: String = "staging.fashionedhealth.com"
    
    public struct QueryModel {
        var key: String
        var value: String
    }
    
    public init() {
        session = URLSession(configuration: .default)
    }
    
    public func addCustomHeader(key: String, value: String) {
        headers[key] = value
    }
    
    public func addQueryItem(key: String, value: String) {
        let newQuery = QueryModel(key: key, value: value)
        queryItems.append(newQuery)
    }
    
    public func addRequestBody<TRequest> (_ body: TRequest?,
                                          _ keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .useDefaultKeys)
    where TRequest: Encodable {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = keyEncodingStrategy
        self.body = try? encoder.encode(body)
    }
    
    public func fetch(path: String, method: String) async throws -> Data {
        guard let url = getUrl(withPath: path) else { fatalError("URL - incorrect format or missing string url") }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if let body = self.body {
            request.httpBody = body
        }
        
        print(request)
        do {
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw ApiRequestError.httpUrlResponseCast
            }
            
            if (200...299).contains(response.statusCode) {
                return data
            } else {
                throw ApiRequestError.backendError(message: "Some error ocurred")
            }
        } catch {
            throw error
        }
    }
    
    private func getUrl(withPath path: String) -> URL? {
        let path = path
        var urlComponents = URLComponents()
        
   // https://alanflament.github.io/TFTest/test.json
        
        urlComponents.scheme = "https"
        urlComponents.host = "alanflament.github.io"
        urlComponents.path = "/\(path)"
        
        urlComponents.queryItems = queryItems.map {
            return URLQueryItem(name: $0.key, value: $0.value)
        }
        
        urlComponents.percentEncodedQuery = urlComponents
            .percentEncodedQuery?
            .replacingOccurrences(of: "+", with: "%2B")
        
        return urlComponents.url?.absoluteURL
    }
    
    func loadImage(stringUrl: String, completion: @escaping (Result<Data, ApiRequestError>) -> Void) {
        guard let url = URL(string: stringUrl) else {
            completion(.failure(.notFound))
            return
        }
        let concurrentPhotoQueue = DispatchQueue(label: "photoQueue", attributes: .concurrent)
        
        concurrentPhotoQueue.async(flags: .barrier) {
            do {
                let imageData = try Data(contentsOf: url)
                completion(.success(imageData))
            } catch {
                completion(.failure(.imageNotFound))
            }
        }
    }
}

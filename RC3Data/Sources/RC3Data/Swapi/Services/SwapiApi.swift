//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 31/10/2021.
//

import Foundation
import Combine

class SwapiApi<TResultItem: Codable, TResultItemDetails: Codable> {
    private let networkManager: NetworkManagerProtocol
    private let url: URL
    
    init(url: URL, networkManager: NetworkManagerProtocol) {
        self.url = url
        self.networkManager = networkManager
    }
    
    func getAll() -> AnyPublisher<[TResultItem], Error> {
        return networkManager.download(url: url)
            .decode(type: SwapiApiResult<TResultItem>.self, decoder: JSONDecoder())
            .map { returnedData in returnedData.results }
            .eraseToAnyPublisher()
    }
    
    func get(url: URL) -> AnyPublisher<TResultItemDetails, Error> {
        return networkManager.download(url: url)
            .decode(type: TResultItemDetails.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    struct SwapiApiResult<T: Codable>: Codable {
        var results: [T]
    }
}

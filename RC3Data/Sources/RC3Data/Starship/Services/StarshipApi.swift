//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation
import Combine

protocol StarshipApiProtocol {
    func getAll() -> AnyPublisher<[StarshipItem], Error>
    func get(url: URL) -> AnyPublisher<StarshipDetails, Error>
}

class StarshipApi: StarshipApiProtocol {
    private let networkManager: NetworkManagerProtocol
    private var subscription: AnyCancellable?
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getAll() -> AnyPublisher<[StarshipItem], Error> {
        guard let url = URL(string: "https://swapi.dev/api/starships") else {
            return Empty().eraseToAnyPublisher()
        }
        
        return networkManager.download(url: url)
            .decode(type: StarshipResult.self, decoder: JSONDecoder())
            .map { returnedResult in returnedResult.results }
            .eraseToAnyPublisher()
    }
    
    func get(url: URL) -> AnyPublisher<StarshipDetails, Error> {
        return networkManager.download(url: url)
            .decode(type: StarshipDetails.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

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
    func get(url: URL) -> AnyPublisher<StarshipItemDetails, Error>
}

class StarshipApi: SwapiApi<StarshipItem, StarshipItemDetails>, StarshipApiProtocol {
    private static let url = URL(string: "https://swapi.dev/api/starships")!

    init() {
        super.init(url: Self.url, networkManager: NetworkManager())
    }
}

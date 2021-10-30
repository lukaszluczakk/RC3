//
//  File.swift
//
//
//  Created by Łukasz Łuczak on 30/10/2021.
//
import Foundation
import Combine
@testable import RC3Data

class StarshipApiMock: StarshipApiProtocol {
    private var starships: [StarshipItem] = []
    private var starshipDetails: StarshipDetails?
    
    init(starships: [StarshipItem]) {
        self.starships = starships
    }
    
    init(starshipDetails: StarshipDetails) {
        self.starshipDetails = starshipDetails
    }
    
    init(starships: [StarshipItem], starshipDetails: StarshipDetails) {
        self.starships = starships
        self.starshipDetails = starshipDetails
    }
    
    func getAll() -> AnyPublisher<[StarshipItem], Error> {
        Just(starships)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func get(url: URL) -> AnyPublisher<StarshipDetails, Error> {
        Just(starshipDetails!)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

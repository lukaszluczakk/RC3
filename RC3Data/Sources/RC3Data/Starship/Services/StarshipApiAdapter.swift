//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation
import Combine

class StarshipApiAdapter: DataApiAdapterProtocol {
    private let starshipApi: StarshipApiProtocol
    private var subscription: AnyCancellable?
    
    init(starshipApi: StarshipApiProtocol) {
        self.starshipApi = starshipApi
    }
    
    func getAll() -> AnyPublisher<[DateItemProtocol], Error>{
        starshipApi.getAll().map(mapStartshipsToStarshipDtos).eraseToAnyPublisher()
    }
}

extension StarshipApiAdapter {
    private func mapStartshipsToStarshipDtos(starships: [Starship]) -> [DateItemProtocol] {
        starships.map {
            StarshipDto(name: $0.name, model: $0.model) {
                "asdadasdas"
            }
        }
    }
}

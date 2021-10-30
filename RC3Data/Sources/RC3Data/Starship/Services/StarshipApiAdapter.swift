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
    
    init(starshipApi: StarshipApiProtocol) {
        self.starshipApi = starshipApi
    }
    
    func getAll() -> AnyPublisher<[DateItemProtocol], Error>{
        starshipApi.getAll().map(mapStartshipsToStarshipDtos).eraseToAnyPublisher()
    }
}

extension StarshipApiAdapter {
    private func mapStartshipsToStarshipDtos(starships: [StarshipItem]) -> [DateItemProtocol] {
        starships.map { item in
            return DataItem(name: item.name, model: item.model, type: .sharship) {
                self.starshipApi.get(url: URL(string: item.url)!)
                    .map { returnedData in DataItemDetails(name: returnedData.name) }
                    .eraseToAnyPublisher()
            }
        }
    }
}

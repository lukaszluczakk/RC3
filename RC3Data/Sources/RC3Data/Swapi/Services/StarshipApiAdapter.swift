//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation
import Combine

class StarshipApiAdapter: DataApiAdapterProtocol {
    private let api: StarshipApiProtocol
    
    init(api: StarshipApiProtocol) {
        self.api = api
    }
    
    func getAll() -> AnyPublisher<[DataItemProtocol], Error>{
        api.getAll().map(mapToDataItem).eraseToAnyPublisher()
    }
}

extension StarshipApiAdapter {
    private func mapToDataItem(starships: [StarshipItem]) -> [DataItemProtocol] {
        starships.map { item in
            return DataItem(name: item.name, model: item.model, type: .starship) {
                self.api.get(url: URL(string: item.url)!)
                    .map { $0.mapToDataItemDetails() }
                    .eraseToAnyPublisher()
            }
        }
    }
}

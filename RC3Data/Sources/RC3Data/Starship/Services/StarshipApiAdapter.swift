//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation
import Combine

class StarshipApiAdapter: DataApiAdapterBase, DataApiAdapterProtocol {
    private let starshipApi: StarshipApiProtocol
    private var subscription: AnyCancellable?
    
    init(starshipApi: StarshipApiProtocol) {
        self.starshipApi = starshipApi
        super.init()
        subscribe()
    }
    
    func getData() {
        starshipApi.getData()
    }
}

extension StarshipApiAdapter {
    private func subscribe() {
        subscription = starshipApi.$data
            .map(mapStartshipsToStarshipDtos)
            .sink { [weak self] returnedData in
                self?.data = returnedData
                self?.subscription?.cancel()
            }
    }
    
    private func mapStartshipsToStarshipDtos(starships: [Starship]) -> [StarshipDto] {
        starships.map { $0.mapToDto() }
    }
}

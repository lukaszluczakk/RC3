//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation
import Combine

public class StarshipApiAdapterBase {
    @Published var data: [StarshipDto] = []
}

public protocol StarshipApiAdapterProtocol: StarshipApiAdapterBase {
    func getData()
}

class StarshipApiAdapter: StarshipApiAdapterBase, StarshipApiAdapterProtocol {
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
    private func mapStartshipsToStarshipDtos(starships: [Starship]) -> [StarshipDto] {
        starships.map { StarshipDto(name: $0.name, model: $0.model, type: .sharship) }
    }
    
    private func subscribe() {
        subscription = starshipApi.$data
            .map(mapStartshipsToStarshipDtos)
            .sink { [weak self] returnedData in
                self?.data = returnedData
                self?.subscription?.cancel()
            }
    }
}

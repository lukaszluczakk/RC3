//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation
import Combine

class StarshipApiBase {
    @Published var data: [Starship] = []
}

protocol StarshipApiProtocol: StarshipApiBase {
    func getData()
}

class StarshipApi: StarshipApiBase, StarshipApiProtocol {
    private let networkManager: NetworkManagerProtocol
    private var marketDatasubscription: AnyCancellable?
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getData() {
        guard let url = URL(string: "https://swapi.dev/api/starships") else {
            return
        }
        
        marketDatasubscription = networkManager.download(url: url)
            .decode(type: [Starship].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: networkManager.handleCompletion, receiveValue: { [weak self] (returnedData) in
                self?.data = returnedData
                self?.marketDatasubscription?.cancel()
            })
    }
}

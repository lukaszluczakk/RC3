//
//  File 2.swift
//  
//
//  Created by Łukasz Łuczak on 29/10/2021.
//

import Foundation
import Combine

class DataApiAdapterComposition: DataApiAdapterProtocol {
    private let starshipApiAdapter: DataApiAdapterProtocol
    private let vehicleApiAdapter: DataApiAdapterProtocol
    
    init(starshipApiAdapter: DataApiAdapterProtocol, vehicleApiAdapter: DataApiAdapterProtocol) {
        self.starshipApiAdapter = starshipApiAdapter
        self.vehicleApiAdapter = vehicleApiAdapter
    }
    
    func getAll() -> AnyPublisher<[DataItemProtocol], Error> {
        Publishers
            .Zip(starshipApiAdapter.getAll(), vehicleApiAdapter.getAll())
            .map { (starships, vehicles) in
                starships + vehicles
            }
            .eraseToAnyPublisher()
    }
}

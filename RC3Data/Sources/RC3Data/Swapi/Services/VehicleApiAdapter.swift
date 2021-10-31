//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 31/10/2021.
//

import Foundation
import Combine

class VehicleApiAdapter: DataApiAdapterProtocol {
    private let api: VehicleApiProtocol
    
    init(api: VehicleApiProtocol) {
        self.api = api
    }
    
    func getAll() -> AnyPublisher<[DataItemProtocol], Error>{
        api.getAll().map(mapToDataItem).eraseToAnyPublisher()
    }
}

extension VehicleApiAdapter {
    private func mapToDataItem(vehicles: [VehicleItem]) -> [DataItemProtocol] {
        vehicles.map { item in
            return DataItem(name: item.name, model: item.model, type: .vehicle) {
                self.api.get(url: URL(string: item.url)!)
                    .map { $0.mapToDataItemDetails() }
                    .eraseToAnyPublisher()
            }
        }
    }
}

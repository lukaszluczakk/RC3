//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 31/10/2021.
//

import Foundation
import Combine

protocol VehicleApiProtocol {
    func getAll() -> AnyPublisher<[VehicleItem], Error>
    func get(url: URL) -> AnyPublisher<VehicleItemDetails, Error>
}

class VehicleApi: SwapiApi<VehicleItem, VehicleItemDetails>, VehicleApiProtocol {
    private static let url = URL(string: "https://swapi.dev/api/vehicles")!

    init() {
        super.init(url: Self.url, networkManager: NetworkManager())
    }
}


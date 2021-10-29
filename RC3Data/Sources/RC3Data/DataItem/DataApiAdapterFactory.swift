//
//  File 2.swift
//  
//
//  Created by Łukasz Łuczak on 29/10/2021.
//

import Foundation

public class DataApiAdapterFactory {
    public static func create() -> DataApiAdapterProtocol {
        DataApiAdapterComposition(starshipApiAdapter: createStarshipApiAdapter(), vehicleApiAdapter: createStarshipApiAdapter())
    }
    
    private static func createStarshipApiAdapter() -> DataApiAdapterProtocol {
        StarshipApiAdapter(starshipApi: StarshipApi(networkManager: NetworkManager()))
    }
}

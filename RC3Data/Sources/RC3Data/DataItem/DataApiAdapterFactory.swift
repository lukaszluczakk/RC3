//
//  File 2.swift
//  
//
//  Created by Łukasz Łuczak on 29/10/2021.
//

import Foundation

public class DataApiAdapterFactory {
    public static func create() -> DataApiAdapterProtocol {
        DataApiAdapterComposition(starshipApiAdapter: createStarshipApiAdapter(), vehicleApiAdapter: createVehicleApiAdapter())
    }
    
    private static func createStarshipApiAdapter() -> DataApiAdapterProtocol {
        StarshipApiAdapter(api: StarshipApi())
    }
    
    private static func createVehicleApiAdapter() -> DataApiAdapterProtocol {
        VehicleApiAdapter(api: VehicleApi())
    }
}

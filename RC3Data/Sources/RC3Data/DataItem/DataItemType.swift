//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation

public enum DataItemType: String {
    case starship, vehicle
    
    public var description: String {
        switch self {
        case .vehicle:
            return "Vehicle"
        case .starship:
            return "Starship"
        }
    }
}

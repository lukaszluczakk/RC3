//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 30/10/2021.
//

import Foundation

struct VehicleItemDetails: Codable {
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let maxAtmospheringSpeed: String
    let crew: String
    let passengers: String
    let cargoCapacity: String
    let consumables: String
    let vehicleClass: String
    
    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer, length, crew, passengers, consumables
        case costInCredits = "cost_in_credits"
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case cargoCapacity = "cargo_capacity"
        case vehicleClass = "vehicle_class"
    }
}

extension VehicleItemDetails {
    func mapToDataItemDetails() -> DataItemDetailsProtocol {
        DataItemDetails(name: self.name, model: self.model, manufacturer: self.manufacturer, costInCredits: self.costInCredits, length: self.length, maxAtmospheringSpeed: self.maxAtmospheringSpeed, crew: self.crew, passengers: self.passengers, cargoCapacity: self.cargoCapacity, consumables: self.consumables, className: self.vehicleClass)
    }
}

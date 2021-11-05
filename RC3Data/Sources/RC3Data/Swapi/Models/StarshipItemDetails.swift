//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 29/10/2021.
//

import Foundation

struct StarshipItemDetails: Codable {
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
    let starshipClass: String
    
    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer, length, crew, passengers, consumables
        case costInCredits = "cost_in_credits"
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case cargoCapacity = "cargo_capacity"
        case starshipClass = "starship_class"
    }
}

extension StarshipItemDetails {
    static var M1 = StarshipItemDetails(name: "M1", model: "Model 1", manufacturer: "Manufacturer M1", costInCredits: "100", length: "200", maxAtmospheringSpeed: "300", crew: "400", passengers: "500", cargoCapacity: "600", consumables: "700", starshipClass: "800")
    
    func mapToDataItemDetails() -> DataItemDetailsProtocol {
        DataItemDetails(name: self.name, model: self.model, manufacturer: self.manufacturer, costInCredits: self.costInCredits, length: self.length, maxAtmospheringSpeed: self.maxAtmospheringSpeed, crew: self.crew, passengers: self.passengers, cargoCapacity: self.cargoCapacity, consumables: self.consumables, className: self.starshipClass)
    }
}

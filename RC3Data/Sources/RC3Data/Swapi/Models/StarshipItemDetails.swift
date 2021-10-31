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
    let mglt: String
    let crew: String
    let passengers: String
    let cargoCapacity: String
    let consumables: String
    let starshipClass: String
    
    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer, length, crew, passengers, consumables
        case costInCredits = "cost_in_credits"
        case mglt = "MGLT"
        case cargoCapacity = "cargo_capacity"
        case starshipClass = "starship_class"
    }
}

extension StarshipItemDetails {
    func mapToDataItemDetails() -> DataItemDetailsProtocol {
        DataItemDetails(name: self.name, model: self.model, manufacturer: self.manufacturer, costInCredits: self.costInCredits, length: self.length, mglt: self.mglt, crew: self.crew, passengers: self.passengers, cargoCapacity: self.cargoCapacity, consumables: self.consumables, className: self.starshipClass)
    }
}

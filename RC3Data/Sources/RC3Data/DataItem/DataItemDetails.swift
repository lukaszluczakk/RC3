//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 29/10/2021.
//

import Foundation

public protocol DataItemDetailsProtocol {
    var name: String { get }
    var model: String { get }
    var manufacturer: String { get }
    var costInCredits: String { get }
    var length: String { get }
    var maxAtmospheringSpeed: String { get }
    var crew: String { get }
    var passengers: String { get }
    var cargoCapacity: String { get }
    var consumables: String { get }
    var className: String { get }
}

class DataItemDetails: DataItemDetailsProtocol {
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
    let className: String
    
    init(name: String, model: String, manufacturer: String, costInCredits: String, length: String, maxAtmospheringSpeed: String, crew: String, passengers: String, cargoCapacity: String, consumables: String, className: String) {
        self.name = name
        self.model = model
        self.manufacturer = manufacturer
        self.costInCredits = costInCredits
        self.length = length
        self.maxAtmospheringSpeed = maxAtmospheringSpeed
        self.crew = crew
        self.passengers = passengers
        self.cargoCapacity = cargoCapacity
        self.consumables = consumables
        self.className = className
    }
}

extension DataItemDetails {
    static var starshipM1 = DataItemDetails(name: "M1", model: "Model M1", manufacturer: "Manufacturer M1", costInCredits: "100", length: "200", maxAtmospheringSpeed: "300", crew: "400", passengers: "500", cargoCapacity: "600", consumables: "700", className: "starship class M1")
    
    static var vehicleM1 = DataItemDetails(name: "M1", model: "Model M1", manufacturer: "Manufacturer M1", costInCredits: "100", length: "200", maxAtmospheringSpeed: "300", crew: "400", passengers: "500", cargoCapacity: "600", consumables: "700", className: "vehicle class M1")
}


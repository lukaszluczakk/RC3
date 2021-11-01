//
//  DataItemDetails.swift
//  RC3Tests
//
//  Created by Łukasz Łuczak on 01/11/2021.
//

import Foundation
import RC3Data

struct DataItemDetails: DataItemDetailsProtocol {
    var name: String
    var model: String
    var manufacturer: String
    var costInCredits: String
    var length: String
    var maxAtmospheringSpeed: String
    var crew: String
    var passengers: String
    var cargoCapacity: String
    var consumables: String
    var className: String
}

extension DataItemDetails {
    static var empty: DataItemDetailsProtocol {
        DataItemDetails(name: "", model: "", manufacturer: "", costInCredits: "", length: "", maxAtmospheringSpeed: "", crew: "", passengers: "", cargoCapacity: "", consumables: "", className: "")
    }
    
    static var M1: DataItemDetailsProtocol {
        DataItemDetails(name: "M1", model: "", manufacturer: "", costInCredits: "", length: "", maxAtmospheringSpeed: "", crew: "", passengers: "", cargoCapacity: "", consumables: "", className: "")
    }
}

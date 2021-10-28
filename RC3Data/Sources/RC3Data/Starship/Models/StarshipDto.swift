//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation

class StarshipDto: DateItemProtocol {
    let name: String
    let model: String
    let type: DataItemType
    
    init(name: String, model: String, type: DataItemType) {
        self.name = name
        self.model = model
        self.type = type
    }
}

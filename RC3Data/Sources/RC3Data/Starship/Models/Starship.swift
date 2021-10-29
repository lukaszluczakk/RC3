//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation

struct StarshipResult: Codable {
    let results: [Starship]
}

struct Starship: Codable {
    let name: String
    let model: String
}

extension Starship {
    func mapToDto() -> StarshipDto {
        StarshipDto(name: self.name, model: self.model)
    }
}

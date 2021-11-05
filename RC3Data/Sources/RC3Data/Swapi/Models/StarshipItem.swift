//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation

struct StarshipItem: Codable {
    let name: String
    let model: String
    let url: String
}

extension StarshipItem {
    static var M1 = StarshipItem(name: "M1", model: "Model M1", url: "http://www.m1.com")
    static var M2 = StarshipItem(name: "M2", model: "Model M2", url: "http://www.m2.com")
}

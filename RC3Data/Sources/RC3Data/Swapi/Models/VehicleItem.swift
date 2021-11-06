//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 30/10/2021.
//

import Foundation

struct VehicleItem : Codable{
    let name: String
    let model: String
    let url: String
}

extension VehicleItem {
    static var M1 = VehicleItem(name: "M1", model: "Model M1", url: "http://www.m1.com")
    static var M2 = VehicleItem(name: "M2", model: "Model M2", url: "http://www.m2.com")
}

//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 29/10/2021.
//

import Foundation

public protocol DataItemDetailsProtocol {
    var name: String { get }
}

class DataItemDetails: DataItemDetailsProtocol {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

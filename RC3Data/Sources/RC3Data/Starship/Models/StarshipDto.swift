//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation

class StarshipDto: DateItemProtocol {
    var select: SelectDataItemDto
    
    let name: String
    let model: String
    let type: DataItemType = .sharship
    
    init(name: String, model: String, select: @escaping SelectDataItemDto) {
        self.name = name
        self.model = model
        self.select = select
    }
}

//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation
import Combine

public typealias SelectingDataItemHandler = () -> AnyPublisher<DataItemDetailsProtocol, Error>

public protocol DataItemProtocol {
    var name: String { get }
    var model: String { get }
    var type: DataItemType { get }
    var select: SelectingDataItemHandler { get }
}

class DataItem: DataItemProtocol {
    let name: String
    let model: String
    let type: DataItemType
    let select: SelectingDataItemHandler
    
    init(name: String, model: String, type: DataItemType, select: @escaping SelectingDataItemHandler) {
        self.name = name
        self.model = model
        self.type = type
        self.select = select
    }
}

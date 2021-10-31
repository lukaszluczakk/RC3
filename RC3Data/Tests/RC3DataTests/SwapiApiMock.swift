//
//  File.swift
//
//
//  Created by Łukasz Łuczak on 30/10/2021.
//
import Foundation
import Combine
@testable import RC3Data

class SwapiApiMock<TDataItem, TDataItemDetails> {
    private var items: [TDataItem] = []
    private var itemDetails: TDataItemDetails?
    
    init(items: [TDataItem]) {
        self.items = items
    }
    
    init(itemDetails: TDataItemDetails) {
        self.itemDetails = itemDetails
    }
    
    init(items: [TDataItem], itemDetails: TDataItemDetails) {
        self.items = items
        self.itemDetails = itemDetails
    }
    
    func getAll() -> AnyPublisher<[TDataItem], Error> {
        Just(items)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func get(url: URL) -> AnyPublisher<TDataItemDetails, Error> {
        Just(itemDetails!)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

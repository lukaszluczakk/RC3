//
//  DataApiAdapterMock.swift
//  RC3Tests
//
//  Created by Łukasz Łuczak on 01/11/2021.
//

import Foundation
import Combine
import RC3Data

class DataApiAdapter: DataApiAdapterProtocol {
    private let dataItems: [DataItemProtocol]
    
    init(dataItems: [DataItemProtocol]) {
        self.dataItems = dataItems
    }
    
    func getAll() -> AnyPublisher<[DataItemProtocol], Error> {
        Just(dataItems)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

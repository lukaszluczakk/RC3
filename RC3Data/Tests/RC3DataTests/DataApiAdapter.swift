//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 30/10/2021.
//

import Foundation
import Combine
import RC3Data

final class DataApiAdapter: DataApiAdapterProtocol {
    private let data: [DataItemProtocol]
    
    init(data: [DataItemProtocol]) {
        self.data = data
    }
    
    func getAll() -> AnyPublisher<[DataItemProtocol], Error> {
        Just(data)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

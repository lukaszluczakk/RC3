//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 29/10/2021.
//

import Foundation
import Combine

public protocol DataApiAdapterProtocol {
    func getAll() -> AnyPublisher<[DataItemProtocol], Error>
}

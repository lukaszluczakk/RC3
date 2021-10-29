//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 29/10/2021.
//

import Foundation

public class DataApiAdapterBase {
    @Published public var data: [DateItemProtocol] = []
}

public protocol DataApiAdapterProtocol: DataApiAdapterBase {
    func getData()
}

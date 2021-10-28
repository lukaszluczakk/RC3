//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation

public protocol DateItemProtocol {
    var name: String { get }
    var model: String { get }
    var type: DataItemType { get }
}

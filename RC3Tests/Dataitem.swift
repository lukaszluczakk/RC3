//
//  Dataitem.swift
//  RC3Tests
//
//  Created by Łukasz Łuczak on 01/11/2021.
//

import Foundation
import RC3Data

struct DataItem: DataItemProtocol {
    var name: String
    var model: String
    var type: DataItemType
    var select: SelectingDataItemHandler
}

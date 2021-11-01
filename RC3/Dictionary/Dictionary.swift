//
//  Dictionary.swift
//  RC3
//
//  Created by Łukasz Łuczak on 01/11/2021.
//

import Foundation

extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        get {
            return self[index(startIndex, offsetBy: i)]
        }
    }
}

//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation

public class StarshipApiAdapterFactory {
    public static func create() -> StarshipApiAdapterProtocol {
        return StarshipApiAdapter(starshipApi: StarshipApi(networkManager: NetworkManager()))
    }
}

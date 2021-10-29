//
//  File 2.swift
//  
//
//  Created by Łukasz Łuczak on 29/10/2021.
//

import Foundation
import Combine

class DataApiAdapterComposition: DataApiAdapterBase, DataApiAdapterProtocol {
    private let starshipApiAdapter: DataApiAdapterProtocol
    private let vehicleApiAdapter: DataApiAdapterProtocol
    private var subscription: AnyCancellable?
    
    init(starshipApiAdapter: DataApiAdapterProtocol, vehicleApiAdapter: DataApiAdapterProtocol) {
        self.starshipApiAdapter = starshipApiAdapter
        self.vehicleApiAdapter = vehicleApiAdapter
        super.init()
        subscribe()
    }
    
    func getData() {
        starshipApiAdapter.getData()
        vehicleApiAdapter.getData()
    }
}

extension DataApiAdapterComposition {
    private func subscribe() {
        subscription = starshipApiAdapter.$data
            .combineLatest(vehicleApiAdapter.$data)
            .sink { [weak self] (sharshipData, vehicleData) in
                self?.data = [sharshipData, vehicleData].flatMap({ $0 })
                self?.subscription?.cancel()
            }
    }
}

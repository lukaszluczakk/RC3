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
    private var cancellable = Set<AnyCancellable>()
    
    init(starshipApiAdapter: DataApiAdapterProtocol, vehicleApiAdapter: DataApiAdapterProtocol) {
        self.starshipApiAdapter = starshipApiAdapter
        self.vehicleApiAdapter = vehicleApiAdapter
        super.init()
        subscribe()
    }
    
    func getData() {
        data = []
        vehicleApiAdapter.getData()
        starshipApiAdapter.getData()
    }
}

extension DataApiAdapterComposition {
    private func subscribe() {
        Publishers
            .MergeMany(starshipApiAdapter.$data, vehicleApiAdapter.$data)
            .sink { [weak self] (returnedData) in
                self?.data += returnedData
            }.store(in: &cancellable)
    }
}

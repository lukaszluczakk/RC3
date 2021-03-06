//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 30/10/2021.
//

import XCTest
import Combine
@testable import RC3Data

final class DataApiAdapterCompositionTests: XCTestCase {
    func testGetAllShouldReturnsDataFromSpecificApiAdapters() {
        let apiAdapter = DataApiAdapterComposition(starshipApiAdapter: createStarshipApiAdapter(), vehicleApiAdapter: createVehicleDataApiAdapter())
        
        let exp = expectation(description: "Wait for data")
        
        let cancellable = apiAdapter.getAll().sink { completion in
            print(completion)
        } receiveValue: { (returnedData) in
            XCTAssertEqual(4, returnedData.count)
            XCTAssertEqual(2, returnedData.filter({ $0.type == .starship }).count)
            XCTAssertEqual(2, returnedData.filter({ $0.type == .vehicle }).count)
            
            exp.fulfill()
        }
        
        addTeardownBlock {
            cancellable.cancel()
        }

        wait(for: [exp], timeout: 0.1)
    }
    
    private func createStarshipApiAdapter() -> DataApiAdapterProtocol {
        let data = [
            DataItem(name: "Item 1", model: "Model 1", type: .starship) {
                Just(DataItemDetails.starshipM1)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            },
            DataItem(name: "Item 2", model: "Model 2", type: .starship) {
                Just(DataItemDetails.starshipM1)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        ]
        
        return DataApiAdapter(data: data)
    }
    
    private func createVehicleDataApiAdapter() -> DataApiAdapterProtocol {
        let data = [
            DataItem(name: "Item 3", model: "Model 3", type: .vehicle) {
                Just(DataItemDetails.vehicleM1)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            },
            DataItem(name: "Item 4", model: "Model 4", type: .vehicle) {
                Just(DataItemDetails.vehicleM1)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        ]
        
        return DataApiAdapter(data: data)
    }
}

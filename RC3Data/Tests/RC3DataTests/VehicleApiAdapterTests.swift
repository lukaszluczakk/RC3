//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 31/10/2021.
//

import XCTest
import Combine
@testable import RC3Data

final class VehicleApiAdapterTests: XCTestCase {
    private var apiAdapter: VehicleApiAdapter!
    
    override func setUp() {
        let vehicles: [VehicleItem] = [.M1, .M2]
        let api = VehicleApiMock(items: vehicles, itemDetails: .M1)
        apiAdapter = VehicleApiAdapter(api: api)
    }
    
    override func tearDown() {
        apiAdapter = nil
    }
    
    func testGetAllShouldReturnsVehicles() {

        let exp = expectation(description: "Wait for data")
        var cancellable = Set<AnyCancellable>()
        
        apiAdapter.getAll().sink { completion in
            print(completion)
        } receiveValue: { (returnedData) in
            XCTAssertEqual(2, returnedData.count)
            XCTAssertEqual(VehicleItem.M1.name, returnedData[0].name)
            XCTAssertEqual(VehicleItem.M1.model, returnedData[0].model)
            XCTAssertEqual(DataItemType.vehicle, returnedData[0].type)
            exp.fulfill()
        }.store(in: &cancellable)

        wait(for: [exp], timeout: 0.1)
    }
    
    func testVehicleSelectShouldReturnsVehicleDetails() {
        let exp = expectation(description: "Wait for data")
        var cancellable = Set<AnyCancellable>()
        
        apiAdapter.getAll()
            .sink { completion in
                print(completion)
            } receiveValue: { (returnedData) in
                returnedData[0].select().sink { selectCompletion in
                    print(selectCompletion)
                } receiveValue: { returnedVehicleDetails in
                    self.vehicleDetailsShouldBeEqualDataItemDetails(vehicleDetails: .M1, dataItemDetails: returnedVehicleDetails)
                    exp.fulfill()
                }.store(in: &cancellable)
                
            }.store(in: &cancellable)

        wait(for: [exp], timeout: 0.1)
    }
    
    private func vehicleDetailsShouldBeEqualDataItemDetails(vehicleDetails: VehicleItemDetails, dataItemDetails: DataItemDetailsProtocol) {
        XCTAssertEqual(vehicleDetails.name, dataItemDetails.name)
        XCTAssertEqual(vehicleDetails.model, dataItemDetails.model)
        XCTAssertEqual(vehicleDetails.manufacturer, dataItemDetails.manufacturer)
        XCTAssertEqual(vehicleDetails.costInCredits, dataItemDetails.costInCredits)
        XCTAssertEqual(vehicleDetails.length, dataItemDetails.length)
        XCTAssertEqual(vehicleDetails.maxAtmospheringSpeed, dataItemDetails.maxAtmospheringSpeed)
        XCTAssertEqual(vehicleDetails.crew, dataItemDetails.crew)
        XCTAssertEqual(vehicleDetails.passengers, dataItemDetails.passengers)
        XCTAssertEqual(vehicleDetails.cargoCapacity, dataItemDetails.cargoCapacity)
        XCTAssertEqual(vehicleDetails.consumables, dataItemDetails.consumables)
        XCTAssertEqual(vehicleDetails.vehicleClass, dataItemDetails.className)
    }
    
    class VehicleApiMock: SwapiApiMock<VehicleItem, VehicleItemDetails>, VehicleApiProtocol {
        
    }
}

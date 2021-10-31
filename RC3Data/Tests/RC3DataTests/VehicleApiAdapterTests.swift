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
    func testGetAllShouldReturnsVehicles() {
        let vehicles = [
            VehicleItem(name: "Name 1", model: "Model 1", url: "http://www.google.pl"),
            VehicleItem(name: "Name 2", model: "Model 2", url: "http://www.google.com"),
        ]
        
        let api = VehicleApiMock(items: vehicles)
        let apiAdapter = VehicleApiAdapter(api: api)
        
        let exp = expectation(description: "Wait for data")
        var cancellable = Set<AnyCancellable>()
        
        apiAdapter.getAll().sink { completion in
            print(completion)
        } receiveValue: { (returnedData) in
            XCTAssertEqual(2, returnedData.count)
            XCTAssertEqual(vehicles[0].name, returnedData[0].name)
            XCTAssertEqual(vehicles[0].model, returnedData[0].model)
            XCTAssertEqual(DataItemType.vehicle, returnedData[0].type)
            exp.fulfill()
        }.store(in: &cancellable)

        wait(for: [exp], timeout: 0.1)
    }
    
    func testVehicleSelectShouldReturnsVehicleDetails() {
        let vehicle = VehicleItem(name: "Name 1", model: "Model 1", url: "http://www.google.com")
        let vehicleDetails = VehicleItemDetails(name: "Name 1", model: "Model 1", manufacturer: "Manufacturer 1", costInCredits: "100", length: "200", mglt: "300", crew: "400", passengers: "500", cargoCapacity: "600", consumables: "5 days", vehicleClass: "Vehicle class")
        
        let api = VehicleApiMock(items: [vehicle], itemDetails: vehicleDetails)
        let apiAdapter = VehicleApiAdapter(api: api)
        
        let exp = expectation(description: "Wait for data")
        var cancellable = Set<AnyCancellable>()
        
        apiAdapter.getAll()
            .sink { completion in
                print(completion)
            } receiveValue: { (returnedData) in
                returnedData[0].select().sink { selectCompletion in
                    print(selectCompletion)
                } receiveValue: { returnedVehicleDetails in
                    self.vehicleDetailsShouldBeEqualDataItemDetails(vehicleDetails: vehicleDetails, dataItemDetails: returnedVehicleDetails)
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
        XCTAssertEqual(vehicleDetails.mglt, dataItemDetails.mglt)
        XCTAssertEqual(vehicleDetails.crew, dataItemDetails.crew)
        XCTAssertEqual(vehicleDetails.passengers, dataItemDetails.passengers)
        XCTAssertEqual(vehicleDetails.cargoCapacity, dataItemDetails.cargoCapacity)
        XCTAssertEqual(vehicleDetails.consumables, dataItemDetails.consumables)
        XCTAssertEqual(vehicleDetails.vehicleClass, dataItemDetails.className)
    }
    
    class VehicleApiMock: SwapiApiMock<VehicleItem, VehicleItemDetails>, VehicleApiProtocol {
        
    }
}

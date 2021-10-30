import XCTest
import Combine
@testable import RC3Data

final class StarshipApiAdapterTests: XCTestCase {
    func testGetAllShouldReturnsStarships() {
        let starships = [
            StarshipItem(name: "Name 1", model: "Model 1", url: "http://www.google.pl"),
            StarshipItem(name: "Name 1", model: "Model 2", url: "http://www.google.com"),
        ]
        
        let api = StarshipApiMock(starships: starships)
        let apiAdapter = StarshipApiAdapter(starshipApi: api)
        
        let exp = expectation(description: "Wait for data")
        var cancellable = Set<AnyCancellable>()
        
        apiAdapter.getAll().sink { completion in
            print(completion)
        } receiveValue: { (returnedData) in
            XCTAssertEqual(2, returnedData.count)
            XCTAssertEqual(starships[0].name, returnedData[0].name)
            XCTAssertEqual(starships[0].model, returnedData[0].model)
            exp.fulfill()
        }.store(in: &cancellable)

        wait(for: [exp], timeout: 0.1)
    }
    
    func testStarshipSelectShouldReturnsStarshipDetails() {
        let starship = StarshipItem(name: "Name 1", model: "Model 1", url: "http://www.google.com")
        let starshipDetails = StarshipDetails(name: "Name 1", model: "Model 1", manufacturer: "Manufacturer 1", costInCredits: "100", length: "200", mglt: "300", crew: "400", passengers: "500", cargoCapacity: "600", consumables: "5 days", starshipClass: "Starfighter")
        
        let api = StarshipApiMock(starships: [starship], starshipDetails: starshipDetails)
        let apiAdapter = StarshipApiAdapter(starshipApi: api)
        
        let exp = expectation(description: "Wait for data")
        var cancellable = Set<AnyCancellable>()
        
        apiAdapter.getAll()
            .sink { completion in
                print(completion)
            } receiveValue: { (returnedData) in
                guard returnedData.count == 1 else {
                    XCTFail()
                    return
                }
                
                returnedData[0].select().sink { selectCompletion in
                    print(selectCompletion)
                } receiveValue: { returnedStarshipDetails in
                    self.starshipDetailsShouldBeEqualDataItemDetails(starshipDetails: starshipDetails, dataItemDetails: returnedStarshipDetails)
                    exp.fulfill()
                }.store(in: &cancellable)
                
            }.store(in: &cancellable)

        wait(for: [exp], timeout: 0.1)
    }
    
    private func starshipDetailsShouldBeEqualDataItemDetails(starshipDetails: StarshipDetails, dataItemDetails: DataItemDetailsProtocol) {
        XCTAssertEqual(starshipDetails.name, dataItemDetails.name)
        XCTAssertEqual(starshipDetails.model, dataItemDetails.model)
        XCTAssertEqual(starshipDetails.manufacturer, dataItemDetails.manufacturer)
        XCTAssertEqual(starshipDetails.costInCredits, dataItemDetails.costInCredits)
        XCTAssertEqual(starshipDetails.length, dataItemDetails.length)
        XCTAssertEqual(starshipDetails.mglt, dataItemDetails.mglt)
        XCTAssertEqual(starshipDetails.crew, dataItemDetails.crew)
        XCTAssertEqual(starshipDetails.passengers, dataItemDetails.passengers)
        XCTAssertEqual(starshipDetails.cargoCapacity, dataItemDetails.cargoCapacity)
        XCTAssertEqual(starshipDetails.consumables, dataItemDetails.consumables)
        XCTAssertEqual(starshipDetails.starshipClass, dataItemDetails.className)
    }
}

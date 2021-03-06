import XCTest
import Combine
@testable import RC3Data

final class StarshipApiAdapterTests: XCTestCase {
    private var apiAdapter: StarshipApiAdapter!
    
    override func setUp() {
        let starships: [StarshipItem] = [.M1, .M2]
        let api = StarshipApiMock(items: starships, itemDetails: .M1)
        apiAdapter = StarshipApiAdapter(api: api)
    }
    
    override func tearDown() {
        apiAdapter = nil
    }

    func testGetAllShouldReturnsStarships() {
        let exp = expectation(description: "Wait for data")
        
        let cancellable = apiAdapter.getAll().sink { completion in
            print(completion)
        } receiveValue: { (returnedData) in
            XCTAssertEqual(2, returnedData.count)
            XCTAssertEqual(StarshipItem.M1.name, returnedData[0].name)
            XCTAssertEqual(StarshipItem.M1.model, returnedData[0].model)
            XCTAssertEqual(DataItemType.starship, returnedData[0].type)
            exp.fulfill()
        }
        
        addTeardownBlock {
            cancellable.cancel()
        }

        wait(for: [exp], timeout: 0.1)
    }
    
    func testStarshipSelectShouldReturnsStarshipDetails() {
        let exp = expectation(description: "Wait for data")
        var cancellable = Set<AnyCancellable>()
        
        apiAdapter.getAll()
            .sink { completion in
                print(completion)
            } receiveValue: { (returnedData) in
                returnedData[0].select().sink { selectCompletion in
                    print(selectCompletion)
                } receiveValue: { returnedStarshipDetails in
                    self.starshipDetailsShouldBeEqualDataItemDetails(starshipDetails: .M1, dataItemDetails: returnedStarshipDetails)
                    exp.fulfill()
                }.store(in: &cancellable)
            }.store(in: &cancellable)
        
        addTeardownBlock {
            cancellable.forEach({ $0.cancel() })
        }

        wait(for: [exp], timeout: 0.1)
    }
    
    private func starshipDetailsShouldBeEqualDataItemDetails(starshipDetails: StarshipItemDetails, dataItemDetails: DataItemDetailsProtocol) {
        XCTAssertEqual(starshipDetails.name, dataItemDetails.name)
        XCTAssertEqual(starshipDetails.model, dataItemDetails.model)
        XCTAssertEqual(starshipDetails.manufacturer, dataItemDetails.manufacturer)
        XCTAssertEqual(starshipDetails.costInCredits, dataItemDetails.costInCredits)
        XCTAssertEqual(starshipDetails.length, dataItemDetails.length)
        XCTAssertEqual(starshipDetails.maxAtmospheringSpeed, dataItemDetails.maxAtmospheringSpeed)
        XCTAssertEqual(starshipDetails.crew, dataItemDetails.crew)
        XCTAssertEqual(starshipDetails.passengers, dataItemDetails.passengers)
        XCTAssertEqual(starshipDetails.cargoCapacity, dataItemDetails.cargoCapacity)
        XCTAssertEqual(starshipDetails.consumables, dataItemDetails.consumables)
        XCTAssertEqual(starshipDetails.starshipClass, dataItemDetails.className)
    }
    
    class StarshipApiMock: SwapiApiMock<StarshipItem, StarshipItemDetails>, StarshipApiProtocol {
        
    }
}

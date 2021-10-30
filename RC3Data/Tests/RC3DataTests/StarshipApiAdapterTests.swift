import XCTest
import Combine
@testable import RC3Data

final class RC3DataTests: XCTestCase {
    func testGetAllShouldReturnStarships() {
        let starships = [
            StarshipItem(name: "Item 1", model: "Model 1", url: "http://www.google.pl"),
            StarshipItem(name: "Item 2", model: "Model 2", url: "http://www.google.com"),
        ]
        
        let api = StarshipApiMock(starships: starships)
        let apiAdapter = StarshipApiAdapter(starshipApi: api)
        
        let exp = expectation(description: "Wait for data")
        var cancellable = Set<AnyCancellable>()
        
        apiAdapter.getAll().sink { completion in
            print(completion)
        } receiveValue: { (returnedData) in
            XCTAssertEqual(2, returnedData.count)
            XCTAssertEqual("Item 1", returnedData[0].name)
            XCTAssertEqual("Model 1", returnedData[0].model)
            exp.fulfill()
        }.store(in: &cancellable)

        wait(for: [exp], timeout: 0.1)
    }
    
    func testStarshipSelectShouldReturnStarshipDetails() {
        let starship = StarshipItem(name: "Item 1", model: "Model 1", url: "http://www.google.pl")
        let starshipDetails = StarshipDetails(name: "Detail item 1")
        
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
                } receiveValue: { (starshipDetail) in
                    XCTAssertEqual("Detail item 1", starshipDetail.name)
                    exp.fulfill()
                }.store(in: &cancellable)
                
            }.store(in: &cancellable)

        wait(for: [exp], timeout: 0.1)
    }
}

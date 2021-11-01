//
//  DataItemDetailsViewControlerTests.swift
//  RC3Tests
//
//  Created by Łukasz Łuczak on 01/11/2021.
//

import XCTest
import Combine
import RC3Data
@testable import RC3

class DataItemDetailsViewControlerTests: XCTestCase {
    func testViewDidLoadShouldLoadDataItemDetails() {
        let dataItem = DataItem(name: "M1", model: "M1", type: .vehicle) {
            Just(DataItemDetails.M1)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        let dataSource = DataSource { output in
            XCTAssertEqual(DataItemDetails.M1.name, output.name)
        }
        
        let controller = DataItemDetailsViewControler(tableView: UITableView(), dataSource: dataSource)
        controller.configure(dataItem: dataItem)
        controller.viewDidLoad()
    }
    
    class DataSource: DataItemDetailsSource {
        typealias SetDataSource = (DataItemDetailsProtocol) -> Void
        
        private let setDataSourceCallback: SetDataSource
        
        init(setDataSourceCallback: @escaping SetDataSource) {
            self.setDataSourceCallback = setDataSourceCallback
        }
        
        override func setDataSource(dataItemDetails: DataItemDetailsProtocol) {
            setDataSourceCallback(dataItemDetails)
        }
    }
}

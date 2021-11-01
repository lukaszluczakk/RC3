//
//  RC3Tests.swift
//  RC3Tests
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import XCTest
import Combine
import RC3Data
@testable import RC3

class DataItemListViewControllerTests: XCTestCase {
    func testViewDidLoadShouldLoadDataFromApiAdapter() {
        let dataItem = DataItem(name: "", model: "", type: .vehicle) {
            Just(DataItemDetails.empty)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        let dataItems: [DataItemProtocol] = [dataItem]
        let apiAdapter = DataApiAdapter(dataItems: dataItems)
        let dataSource = DataSource { v in
            XCTAssertEqual(1, v)
        }
        let controller = DataItemListViewController(dataApiAdapter: apiAdapter, tableView: UITableView(), dataSource: dataSource)
        controller.viewDidLoad()
    }
    
    class DataSource: DataItemListSource {
        typealias SetDataSource = (Int) -> Void
        
        private let setDataSourceCallback: SetDataSource
        
        init(setDataSourceCallback: @escaping SetDataSource) {
            self.setDataSourceCallback = setDataSourceCallback
        }
        
        override func setDataSource(dataSource: [DataItemProtocol]) {
            setDataSourceCallback(dataSource.count)
        }
    }
}

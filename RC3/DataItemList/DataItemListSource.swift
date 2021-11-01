//
//  DataItemListSource.swift
//  RC3
//
//  Created by Łukasz Łuczak on 31/10/2021.
//

import Foundation
import UIKit
import RC3Data

protocol DataItemListSourceProtocol: NSObject, UITableViewDataSource {
    func setDataSource(dataSource: [DataItemProtocol])
    func item(at row: Int) -> DataItemProtocol
}

class DataItemListSource: NSObject, DataItemListSourceProtocol {
    private var dataSource: [DataItemProtocol] = []
    
    func setDataSource(dataSource: [DataItemProtocol]) {
        self.dataSource = dataSource
    }
    
    func item(at row: Int) -> DataItemProtocol {
        dataSource[row]
    }
}

extension DataItemListSource: UITableViewDataSource {
    private static let cellIdentifier = "DataItemListViewCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath) as? DataItemListViewCell else {
            fatalError("Unable to dequeue cell")
        }
        
        let dataItem = item(at: indexPath.row)
        
        cell.configure(name: dataItem.name, model: dataItem.model, type: dataItem.type.description)
        
        return cell
    }
}

//
//  DataItemDetailsSource.swift
//  RC3
//
//  Created by Łukasz Łuczak on 01/11/2021.
//

import UIKit
import RC3Data

class DataItemDetailsSource: NSObject {
    private var dataSource: [String:String] = [:]
    
    func setDataSource(dataItemDetails: DataItemDetailsProtocol) {
        self.dataSource = prepareDataSource(dataItemDetails: dataItemDetails)
    }
    
    func item(at row: Int) -> (key: String, value: String) {
        dataSource[row]
    }
    
    private func prepareDataSource(dataItemDetails: DataItemDetailsProtocol) -> [String: String] {
        [
            "Name": dataItemDetails.name,
            "Model": dataItemDetails.model,
            "Manufacturer": dataItemDetails.manufacturer,
            "Cost in credits": dataItemDetails.costInCredits,
            "Length": dataItemDetails.length,
            "MGLT": dataItemDetails.mglt,
            "Crew": dataItemDetails.crew,
            "Passengers": dataItemDetails.passengers,
            "Cargo capacity": dataItemDetails.cargoCapacity,
            "Consumables": dataItemDetails.consumables,
            "Class": dataItemDetails.className
        ]
    }
}

extension DataItemDetailsSource: UITableViewDataSource {
    private static let cellIdentifier = "DataItemDetailViewCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath) as? DataItemDetailViewCell else {
            fatalError("Unable to dequeue cell")
        }
        
        let data = item(at: indexPath.row)
        cell.configure(name: data.key, value: data.value)
        
        return cell
    }
}

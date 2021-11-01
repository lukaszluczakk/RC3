//
//  DataItemDetailsSource.swift
//  RC3
//
//  Created by Łukasz Łuczak on 01/11/2021.
//

import UIKit
import RC3Data

class DataItemDetailsSource: NSObject {
    private var dataItemDetails: DataItemDetailsProtocol!
     
    func setDataSource(dataItemDetails: DataItemDetailsProtocol) {
        self.dataItemDetails = dataItemDetails
    }
}

extension DataItemDetailsSource: UITableViewDataSource {
    private static let cellIdentifier = "DataItemDetailViewCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         DataItemDetail.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath) as? DataItemDetailViewCell else {
            fatalError("Unable to dequeue cell")
        }
        
        let dataItemDetail = DataItemDetail.allCases[indexPath.row]
        let name = dataItemDetail.name
        let value = dataItemDetail.value(for: dataItemDetails)

        cell.configure(name: name, value: value)
        
        return cell
    }
}

extension DataItemDetailsSource {
    enum DataItemDetail: String, CaseIterable {
        case name, model, manufacturer, costInCredits, length, maxAtmospheringSpeed, crew, passengers, cargoCapacity, consumables, className
        
        func value(for dataItemDetails: DataItemDetailsProtocol?) -> String? {
            switch self {
            case .name:
                return dataItemDetails?.name
            case .model:
                return dataItemDetails?.model
            case .manufacturer:
                return dataItemDetails?.manufacturer
            case .costInCredits:
                return dataItemDetails?.costInCredits
            case .length:
                return dataItemDetails?.length
            case .maxAtmospheringSpeed:
                return dataItemDetails?.maxAtmospheringSpeed
            case .crew:
                return dataItemDetails?.crew
            case .passengers:
                return dataItemDetails?.passengers
            case .cargoCapacity:
                return dataItemDetails?.cargoCapacity
            case .consumables:
                return dataItemDetails?.consumables
            case .className:
                return dataItemDetails?.className
            }
        }
        
        var name: String {
            switch self {
            case .name:
                return "Name"
            case .model:
                return "Model"
            case .manufacturer:
                return "Manufacturer"
            case .costInCredits:
                return "Cost in credits"
            case .length:
                return "Length"
            case .maxAtmospheringSpeed:
                return "Max atmosphering speed"
            case .crew:
                return "Crew"
            case .passengers:
                return "Passengers"
            case .cargoCapacity:
                return "Cargo capacity"
            case .consumables:
                return "Consumables"
            case .className:
                return "Class"
            }
        }
    }
}

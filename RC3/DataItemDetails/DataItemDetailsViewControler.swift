//
//  DataItemViewController.swift
//  RC3
//
//  Created by Łukasz Łuczak on 29/10/2021.
//

import UIKit
import RC3Data
import Combine

class DataItemDetailsViewControler: UITableViewController {
    
    @IBOutlet var nameLabel: UILabel!
    
    private var dataItemDetails: DataItemDetailsProtocol!
    private var cancellable = Set<AnyCancellable>()
    
    func configure(dataItem: DataItemProtocol){
        dataItem.select()
            .receive(on: DispatchQueue.main)
            .sink { Status in
                print(Status)
            } receiveValue: { returnedData in }.store(in: &cancellable)
    }
}

//
//  DataItemViewController.swift
//  RC3
//
//  Created by Łukasz Łuczak on 29/10/2021.
//

import UIKit
import RC3Data

class DataItemDetailsViewControler: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    
    private var dataItemDetails: DataItemDetailsProtocol!
    
    func configure(dataItemDetails: DataItemDetailsProtocol){
        nameLabel.text = dataItemDetails.name
    }
}

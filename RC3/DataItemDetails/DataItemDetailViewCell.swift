//
//  DataItemDetailViewCell.swift
//  RC3
//
//  Created by Łukasz Łuczak on 01/11/2021.
//

import UIKit
import RC3Data

class DataItemDetailViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    func configure(name: String, value: String?) {
        nameLabel.text = name
        valueLabel.text = value
    }
}

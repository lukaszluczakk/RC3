//
//  Cell.swift
//  RC3
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import UIKit

class DataItemListViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var modelLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    
    func configure(name: String, model: String, type: String) {
        nameLabel.text = name
        modelLabel.text = model
        typeLabel.text = type
    }
}

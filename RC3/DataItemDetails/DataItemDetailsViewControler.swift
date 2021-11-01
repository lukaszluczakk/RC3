//
//  DataItemDetailsViewControler.swift
//  RC3
//
//  Created by Łukasz Łuczak on 29/10/2021.
//

import UIKit
import RC3Data
import Combine

class DataItemDetailsViewControler: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    private var dataItem: DataItemProtocol!
    private var dataSource: DataItemDetailsSourceProtocol!
    private var cancellable = Set<AnyCancellable>()
    
    init(tableView: UITableView, dataSource: DataItemDetailsSourceProtocol) {
        self.tableView = tableView
        self.dataSource = dataSource
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dataSource = DataItemDetailsSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = DataItemDetailsSource()
        tableView.dataSource = dataSource
        
        dataItem.select()
            .receive(on: DispatchQueue.main)
            .sink { Status in
                print(Status)
            } receiveValue: { [weak self] returnedData in
                self?.dataSource.setDataSource(dataItemDetails: returnedData)
                self?.tableView.reloadData()
            }.store(in: &cancellable)
    }
    
    func configure(dataItem: DataItemProtocol){
        self.dataItem = dataItem
    }
}

//
//  ViewController.swift
//  RC3
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import UIKit
import Combine
import RC3Data

class DataItemListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    private var dataApiAdapter: DataApiAdapterProtocol!
    private var dataSource: DataItemListSourceProtocol!
    private var cancellable = Set<AnyCancellable>()
    
    init(dataApiAdapter: DataApiAdapterProtocol, tableView: UITableView, dataSource: DataItemListSourceProtocol) {
        self.dataApiAdapter = dataApiAdapter
        self.tableView = tableView
        self.dataSource = dataSource
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dataApiAdapter = DataApiAdapterFactory.create()
        dataSource = DataItemListSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        
        dataApiAdapter.getAll()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion) { err in
                    self?.showError(title: "Item list error", message: err.localizedDescription)
                }
            } receiveValue: { [weak self] returnedData in
                self?.dataSource.setDataSource(dataSource: returnedData)
                self?.tableView.reloadData()
            }.store(in: &cancellable)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let dataItemController = segue.destination as! DataItemDetailsViewControler
            let selectedItem = dataSource.item(at: selectedRow)
            dataItemController.configure(dataItem: selectedItem)
        }
    }
}


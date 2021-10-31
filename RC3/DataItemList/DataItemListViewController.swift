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
    private var dataSource: DataItemListSource!
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataApiAdapter = DataApiAdapterFactory.create()
        dataSource = DataItemListSource()
        tableView.dataSource = dataSource

        dataApiAdapter.getAll()
            .receive(on: DispatchQueue.main)
            .sink { status in
                print(status)
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

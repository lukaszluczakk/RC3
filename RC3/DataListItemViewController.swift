//
//  ViewController.swift
//  RC3
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import UIKit
import Combine
import RC3Data

class DataListItemViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var dataApiAdapter: DataApiAdapterProtocol!
    private var dataSource: DataSource!
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataApiAdapter = DataApiAdapterFactory.create()
        dataSource = DataSource()
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
                selectedItem.select()
                    .receive(on: DispatchQueue.main)
                    .sink { Status in
                    print(Status)
                } receiveValue: { returnedData in
                    dataItemController.configure(dataItemDetails: returnedData)
                }.store(in: &cancellable)

            }
        }
}

class DataSource: NSObject {
    private var dataSource: [DateItemProtocol] = []
    
    func setDataSource(dataSource: [DateItemProtocol]) {
        self.dataSource = dataSource
    }
    
    func item(at row: Int) -> DateItemProtocol {
        dataSource[row]
    }
}

extension DataSource: UITableViewDataSource {
    private static let cellIdentifier = "TableViewCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath) as? DataItemListCellView else {
            fatalError("Unable to dequeue cell")
        }
        
        let dataItem = item(at: indexPath.row)
        
        cell.nameLabel.text = dataItem.name
        
        return cell
    }
}

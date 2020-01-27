//
//  TableViewDataSource.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 27/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import UIKit

protocol TableCellDelegate: UITableViewCell {
    associatedtype ViewModel
    func configureCell(withViewModel viewModel:ViewModel)
    static var cellIdentifier: String {get}
}

class TableViewDataSource<CellType>:NSObject, UITableViewDataSource where CellType: TableCellDelegate {

    var items:[CellType.ViewModel]

    init(viewModelItems: [CellType.ViewModel]) {
        self.items = viewModelItems
    }
    
    func updateViewModel(withViewModelItems viewModelItems:[CellType.ViewModel]){
        self.items = viewModelItems
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellType.cellIdentifier, for: indexPath) as? CellType else {
            fatalError("Could not initialize cell for identifier \(CellType.cellIdentifier)")
        }
        cell.configureCell(withViewModel:items[indexPath.row])
        return cell
    }
}

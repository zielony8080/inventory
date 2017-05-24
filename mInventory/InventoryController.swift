//
//  InventoryController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 18.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class InventoryController: UITableViewController {

    var stockService = StockService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stockService.findAll()
    }
}

//MARK: - UITableViewDataSource
extension InventoryController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockService.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stock", for: indexPath)
        let stock = stockService.object(at: indexPath)
        
        cell.configure(with: stock)

        return cell
    }
    
}

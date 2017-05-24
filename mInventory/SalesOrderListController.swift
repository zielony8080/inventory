//
//  SalesOrderController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 09.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SalesOrderListController: UITableViewController, RefreshableDelegate {
    
    var salesOrderService: SalesOrderService = SalesOrderService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SalesOrderListController.add(_:)))
        navigationItem.rightBarButtonItems = [addBarButtonItem]
        
        salesOrderService.findAll()
    }
    
    func refresh() {
        salesOrderService.findAll()
        tableView.reloadData()
    }
    
    func add(_ sender: UIBarButtonItem) {
        edit(salesOrder: nil)
    }
    
    func edit(salesOrder: SalesOrder?) {
        let salesOrderViewController =  storyboard!.instantiateViewController(withIdentifier: "SalesOrderViewController") as! SalesOrderViewController
        salesOrderViewController.salesOrder = salesOrder
        salesOrderViewController.modalPresentationStyle = .popover
        salesOrderViewController.modalTransitionStyle = .coverVertical
        salesOrderViewController.refreshable = self
        navigationController?.pushViewController(salesOrderViewController, animated: true)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension SalesOrderListController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salesOrderService.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SalesOrder", for: indexPath)
        
        let salesOrder = salesOrderService.object(at: indexPath)
        cell.textLabel?.text = "\(salesOrder.number!) (\(salesOrder.status!))"
        cell.detailTextLabel?.text = salesOrder.customer?.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let salesOrder = salesOrderService.object(at: indexPath) as SalesOrder
        edit(salesOrder: salesOrder)
    }
}



//
//  SupplierListController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 09.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SupplierListController: UITableViewController {
    
    var supplierService: SupplierService = SupplierService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SupplierListController.add(_:)))
        navigationItem.rightBarButtonItems = [addBarButtonItem]
        
        supplierService.findAll()
    }
    
    func reloadData() {
        supplierService.findAll()
        tableView.reloadData()
    }
    
    func add(_ sender: UIBarButtonItem) {
        edit(supplier: nil)
    }
    
    func edit(supplier: Supplier?) {
        let supplierViewController =  storyboard!.instantiateViewController(withIdentifier: "SupplierViewController") as! SupplierViewController
        supplierViewController.supplier = supplier
        supplierViewController.modalPresentationStyle = .popover
        supplierViewController.modalTransitionStyle = .coverVertical
        supplierViewController.owner = self
        navigationController?.pushViewController(supplierViewController, animated: true)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension SupplierListController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supplierService.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Supplier", for: indexPath)
        
        let supplier = supplierService.object(at: indexPath) as Supplier
        cell.textLabel?.text = supplier.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let supplier = supplierService.object(at: indexPath) as Supplier
        edit(supplier: supplier)
    }
    
    
}



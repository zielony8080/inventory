//
//  PackingSlipListController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 13.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class PackingSlipListController: UITableViewController, RefreshableDelegate {
    
    var packingSlipService: PackingSlipService = PackingSlipService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(PackingSlipListController.add(_:)))
        navigationItem.rightBarButtonItems = [addBarButtonItem]
        
        packingSlipService.findAll()
    }
    
    func refresh() {
        packingSlipService.findAll()
        tableView.reloadData()
    }
    
    func add(_ sender: UIBarButtonItem) {
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "SelectNSManagedObjectController") as! SelectNSManagedObjectController
        controller.modalPresentationStyle = .popover
        controller.modalTransitionStyle = .coverVertical
        controller.searchPredicate = NSPredicate(format: "status == %@", "in progress")
        controller.service = SalesOrderService()
        controller.onSelectFunction = { (salesOrder: NSManagedObject?) -> () in
            if let salesOrder = salesOrder as? SalesOrder {
                let packingSlip = self.packingSlipService.newInstance(forSalesOrder: salesOrder)
                self.packingSlipService.save()
                self.edit(packingSlip: packingSlip)
            }
        }
    
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func edit(packingSlip: PackingSlip?) {
        let packingSlipViewController =  storyboard!.instantiateViewController(withIdentifier: "PackingSlipViewController") as! PackingSlipViewController
        packingSlipViewController.packingSlip = packingSlip
        packingSlipViewController.modalPresentationStyle = .popover
        packingSlipViewController.modalTransitionStyle = .coverVertical
        packingSlipViewController.refreshable = self
        navigationController?.pushViewController(packingSlipViewController, animated: true)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension PackingSlipListController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packingSlipService.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackingSlip", for: indexPath)
        
        let packingSlip = packingSlipService.object(at: indexPath)
        cell.textLabel?.text = "\(packingSlip.number!) (\(packingSlip.status!))"
        cell.detailTextLabel?.text = packingSlip.customer?.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let packingSlip = packingSlipService.object(at: indexPath) as PackingSlip
        edit(packingSlip: packingSlip)
    }
}



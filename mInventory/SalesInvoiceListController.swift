//
//  SalesInvoiceViewController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 17.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SalesInvoiceListController: UITableViewController, RefreshableDelegate {

    var salesInvoiceService: SalesInvoiceService = SalesInvoiceService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SalesInvoiceListController.add(_:)))
        navigationItem.rightBarButtonItems = [addBarButtonItem]
        
        salesInvoiceService.findAll()
    }
    
    func add(_ sender: UIBarButtonItem) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "SelectNSManagedObjectController") as! SelectNSManagedObjectController
        controller.modalPresentationStyle = .popover
        controller.modalTransitionStyle = .coverVertical
        controller.searchPredicate = NSPredicate(format: "status == %@", "in progress")
        controller.service = PackingSlipService()
        controller.onSelectFunction = { (packingSlip: NSManagedObject?) -> () in
            if let packingSlip = packingSlip as? PackingSlip {
                let salesInvoice = self.salesInvoiceService.newInstance(packingSlip: packingSlip)
                self.salesInvoiceService.save()
                //let _ = self.navigationController?.popViewController(animated: true)
                self.edit(salesInvoice: salesInvoice)
            }
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func edit(salesInvoice: SalesInvoice) {
        let salesInvoiceViewController =  storyboard!.instantiateViewController(withIdentifier: "SalesInvoiceViewController") as! SalesInvoieceViewController
        salesInvoiceViewController.salesInvoice = salesInvoice
        salesInvoiceViewController.modalPresentationStyle = .popover
        salesInvoiceViewController.modalTransitionStyle = .coverVertical
        salesInvoiceViewController.refreshable = self
        
        navigationController?.pushViewController(salesInvoiceViewController, animated: true)
    }

    
    func refresh() {
        tableView.reloadData()
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SalesInvoiceListController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let salesInvoice = salesInvoiceService.object(at: indexPath)
        edit(salesInvoice: salesInvoice)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salesInvoiceService.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SalesInvoice", for: indexPath)
        
        let salesInvoice = salesInvoiceService.object(at: indexPath)
        cell.textLabel?.text = "\(salesInvoice.number!) (\(salesInvoice.status!))"
        cell.detailTextLabel?.text = salesInvoice.customer?.name
        
        return cell
    }
}

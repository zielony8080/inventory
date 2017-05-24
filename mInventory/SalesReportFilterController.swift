//
//  SalesFilterController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 18.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SalesReportFilterController: UITableViewController {

    @IBOutlet weak var customerViewCell: UITableViewCell!
    @IBOutlet weak var productViewCell: UITableViewCell!

    var customer: Customer?
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clear()

        self.navigationController!.setToolbarHidden(false, animated: true)
        
        var items = [UIBarButtonItem]()
        let clearButton = UIBarButtonItem(title: "Clear", style: UIBarButtonItemStyle.done, target: self, action: #selector(SalesReportFilterController.clear))
        let searchButton = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.done, target: self, action: #selector(SalesReportFilterController.search))

        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(clearButton)
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(searchButton)
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        
        self.toolbarItems = items

        
    }
    
    func clear() {
        customer = nil
        customerViewCell.textLabel?.text = "Select customer"
        customerViewCell.detailTextLabel?.text = ""
        customerViewCell.configure(with: customer)
        
        product = nil
        productViewCell.textLabel?.text = "Select product"
        productViewCell.detailTextLabel?.text = ""
        productViewCell.configure(with: product)
        
        tableView.reloadData()
    }
    
    
    func search() {
        let productViewController =  storyboard!.instantiateViewController(withIdentifier: "SalesReportResultController") as! SalesReportResultController
        productViewController.customer = customer
        productViewController.product = product
        productViewController.modalPresentationStyle = .popover
        productViewController.modalTransitionStyle = .coverVertical
        
        navigationController?.pushViewController(productViewController, animated: true)

    }
}

//MARK: - UITableViewDataSource
extension SalesReportFilterController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell == customerViewCell {
            let controller = storyboard!.instantiateViewController(withIdentifier: "SelectNSManagedObjectController") as! SelectNSManagedObjectController
            controller.modalPresentationStyle = .popover
            controller.modalTransitionStyle = .coverVertical
            controller.service = CustomerService()
            controller.onSelectFunction = {(customer: NSManagedObject?) -> () in
                self.customer = customer as? Customer
                self.customerViewCell.configure(with: self.customer )
            }
            
            navigationController?.pushViewController(controller, animated: true)
        }
        
        if cell == productViewCell {
            let controller = storyboard!.instantiateViewController(withIdentifier: "SelectNSManagedObjectController") as! SelectNSManagedObjectController
            controller.modalPresentationStyle = .popover
            controller.modalTransitionStyle = .coverVertical
            controller.service = ProductService()
            controller.onSelectFunction = {(product: NSManagedObject?) -> () in
                self.product = product as? Product
                self.productViewCell.configure(with: self.product )
            }
            
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
}

//
//  CustomerListController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 08.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class CustomerListController: UITableViewController {

    var customerService: CustomerService = CustomerService()

    override func viewDidLoad() {
        super.viewDidLoad()

        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CustomerListController.add(_:)))
        navigationItem.rightBarButtonItems = [addBarButtonItem]

        customerService.findAll()
    }
    
    func reloadData() {
        customerService.findAll()
        tableView.reloadData()
    }

    func add(_ sender: UIBarButtonItem) {
        edit(customer: nil)
    }
    
    func edit(customer: Customer?) {
        let customerViewController =  storyboard!.instantiateViewController(withIdentifier: "CustomerViewController") as! CustomerViewController
        customerViewController.customer = customer
        customerViewController.modalPresentationStyle = .popover
        customerViewController.modalTransitionStyle = .coverVertical
        customerViewController.owner = self
        navigationController?.pushViewController(customerViewController, animated: true)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension CustomerListController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerService.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Customer", for: indexPath)
        
        let customer = customerService.object(at: indexPath) as Customer
        cell.textLabel?.text = customer.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customer = customerService.object(at: indexPath) as Customer
        edit(customer: customer)
    }
    

}



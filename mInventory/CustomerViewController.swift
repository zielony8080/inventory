//
//  CustomerViewController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 08.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var termOfPaymentsTextField: UITextField!

    var customerService: CustomerService = CustomerService()
    var customer: Customer?
    var owner: CustomerListController!

    override func viewDidLoad() {
        super.viewDidLoad()

        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(CustomerViewController.save(_:)))
        navigationItem.rightBarButtonItems = [addBarButtonItem]
        
        nameTextField.text = customer?.name
        addressTextField.text = customer?.address
        if let customer = customer {
            termOfPaymentsTextField.text = String(describing: customer.termOfPayment)
        }
    }

    func save(_ sender: UIBarButtonItem) {

        let name = nameTextField.text ?? ""
        if  name.isEmpty {
            AlertController.info(title: "Validation error!", message: "Customer name is required.", inController: self)
            return
        }

        let address = addressTextField.text ?? ""
        if  address.isEmpty {
            AlertController.info(title: "Validation error!", message: "Customer address is required.", inController: self)
            return
        }
        
        let termOfPayments = termOfPaymentsTextField.text ?? ""
        if  termOfPayments.isEmpty {
            AlertController.info(title: "Validation error!", message: "Customer term of payments is required.", inController: self)
            return
        }

        if customer == nil {
            customer = customerService.newInstance()
        }

        customer?.name = name
        customer?.address = address
        customer?.termOfPayment = Int16(termOfPayments)!
        
        
        customerService.save()

        let _ = navigationController?.popViewController(animated: true)
        owner.reloadData()
    }
    
    
}

//
//  SupplierViewController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 09.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit

class SupplierViewController: UIViewController {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var supplierService: SupplierService = SupplierService()
    var supplier: Supplier?
    var owner: SupplierListController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(SupplierViewController.save(_:)))
        navigationItem.rightBarButtonItems = [addBarButtonItem]
        
        nameTextField.text = supplier?.name
        addressTextField.text = supplier?.address
        
    }
    
    func save(_ sender: UIBarButtonItem) {
        
        let name = nameTextField.text ?? ""
        if  name.isEmpty {
            AlertController.info(title: "Validation error!", message: "Supplier name is required.", inController: self)
            return
        }
        
        let address = addressTextField.text ?? ""
        if  address.isEmpty {
            AlertController.info(title: "Validation error!", message: "Supplier address is required.", inController: self)
            return
        }

        if supplier == nil {
            supplier = supplierService.newInstance()
        }
        
        supplier?.name = name
        supplier?.address = address
        supplierService.save()
        
        let _ = navigationController?.popViewController(animated: true)
        owner.reloadData()
    }
    
    
}

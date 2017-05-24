//
//  ProductViewController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 05.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class ProductViewController: UIViewController {

    @IBOutlet weak var taxSegmentControl: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var supplierTextField: UITextField!

    var taxService: TaxService = TaxService()
    var productService: ProductService = ProductService()

    var product: Product?
    var supplier : Supplier?
    var owner: ProductListController!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(ProductViewController.saveProduct(_:)))
        navigationItem.rightBarButtonItems = [addBarButtonItem]

        taxService.findAll()

        // update fields
        nameTextField.text = product?.name
        supplierTextField.text = product?.supplier?.name
        supplier = product?.supplier
        
        taxSegmentControl.removeAllSegments()
        for index in 0..<taxService.count() {
            let tax =  taxService.object(at: IndexPath(row: index, section: 0))
            taxSegmentControl.insertSegment(withTitle: "\(tax.name!)", at: index, animated:false)
            if tax.name == product?.tax?.name {
                taxSegmentControl.selectedSegmentIndex = index
            }
        }
    }
    
    
    func onSupplierSelected(_ supplier: NSManagedObject?) {
        self.supplier = supplier as? Supplier
        supplierTextField.text = self.supplier?.name ?? ""
    }

    @IBAction func selectSupplier(_ sender: UIButton) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "SelectNSManagedObjectController") as! SelectNSManagedObjectController
        controller.modalPresentationStyle = .popover
        controller.modalTransitionStyle = .coverVertical
        
        controller.onSelectFunction = onSupplierSelected(_:)
        controller.service = SupplierService()
        
        navigationController?.pushViewController(controller, animated: true)
    
    }
    
    @IBAction func saveProduct(_ sender: UIBarButtonItem) {

        if supplier == nil {
            AlertController.info(title: "Validation error!", message: "Supplier is required.", inController: self)
            return
        }

        if taxSegmentControl.selectedSegmentIndex == -1 {
            AlertController.info(title: "Validation error!", message: "Tax is required.", inController: self)
            return
        }

        let indexPath = IndexPath(row: taxSegmentControl.selectedSegmentIndex, section: 0)
        let tax = taxService.object(at: indexPath)

        let name = nameTextField.text ?? ""
        if  name.isEmpty {
            AlertController.info(title: "Validation error!", message: "Product name is required.", inController: self)
            return
        }
        
        if product == nil {
            product = productService.newInstance()
        }

        product!.name = name
        product!.tax = tax
        product!.supplier = supplier
        
        productService.save()
        
        let _ = navigationController?.popViewController(animated: true)
        owner!.reloadData()
    }

}

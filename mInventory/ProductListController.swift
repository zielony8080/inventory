//
//  ProductsControllerTableViewController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 05.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class ProductListController: UITableViewController {

    //var productController: NSFetchedResultsController<Product>!
    var productService: ProductService = ProductService()

    override func viewDidLoad() {
        super.viewDidLoad()

        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ProductListController.add(_:)))

        navigationItem.rightBarButtonItems = [addBarButtonItem]

        //productController = productService.performFeatchAll()
        productService.findAll()
    }
    
    func reloadData() {
        //productController = productService.performFeatchAll()
        productService.findAll()
        tableView.reloadData()
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        edit(product: nil)
    }

    func edit(product: Product?) {
        let productViewController =  storyboard!.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        productViewController.product = product
        productViewController.modalPresentationStyle = .popover
        productViewController.modalTransitionStyle = .coverVertical
        productViewController.owner = self
        navigationController?.pushViewController(productViewController, animated: true)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ProductListController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productService.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath)
        
        let product = productService.object(at: indexPath) as Product
        cell.textLabel?.text = product.name
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = productService.object(at: indexPath)
        self.edit(product: product)
        
    }
}


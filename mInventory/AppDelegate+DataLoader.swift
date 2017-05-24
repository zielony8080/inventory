//
//  DataLoader.swift
//  mInventory
//
//  Created by Łukasz Zielony on 05.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData

extension AppDelegate {
    
    func loadData() {
        loadTaxes()
        loadCustomers()
        loadSuppliers()
        loadProducts()
        loadStock()
     }
    
    fileprivate func loadTaxes() {
        let taxFetch: NSFetchRequest<Tax> = Tax.fetchRequest()
        let count = try! self.persistentContainer.viewContext.count(for: taxFetch)
        
        if count == 0 {
            let path = Bundle.main.path(forResource: "Taxes", ofType: "plist")
            let dataArray = NSArray(contentsOfFile: path!)!
            
            for dict in dataArray {
                let taxDict = dict as! [String: String]
                let tax = Tax(context: persistentContainer.viewContext)
                
                tax.name = taxDict["name"]!
                tax.factor = NSDecimalNumber(string: taxDict["factor"]!)
            }
        }

        try! persistentContainer.viewContext.save()
        
    }
    
    fileprivate func loadCustomers() {
        
        let fetchRequest: NSFetchRequest<Customer> = Customer.fetchRequest()
        let count = try! self.persistentContainer.viewContext.count(for: fetchRequest)
        
        if count == 0 {
            let path = Bundle.main.path(forResource: "Customers", ofType: "plist")
            let dataArray = NSArray(contentsOfFile: path!)!
            
            for dict in dataArray {
                let taxDict = dict as! [String: String]
                let entity = Customer(context: persistentContainer.viewContext)
                
                entity.name = taxDict["name"]!
                entity.address = taxDict["address"]!
                entity.termOfPayment = Int16(taxDict["termOfPayment"]!)!
            }
        }
        
        try! persistentContainer.viewContext.save()
        
    }
    
    fileprivate func loadSuppliers() {
        
        let fetchRequest: NSFetchRequest<Supplier> = Supplier.fetchRequest()
        let count = try! self.persistentContainer.viewContext.count(for: fetchRequest)
        
        if count == 0 {
            let path = Bundle.main.path(forResource: "Suppliers", ofType: "plist")
            let dataArray = NSArray(contentsOfFile: path!)!
            
            for dict in dataArray {
                let supplierDict = dict as! [String: String]
                let entity = Supplier(context: persistentContainer.viewContext)
                
                entity.name = supplierDict["name"]!
                entity.address = supplierDict["address"]!
            }
        }
        
        try! persistentContainer.viewContext.save()
        
    }
    
    fileprivate func loadProducts() {
        
        let taxes = TaxService().dictionary(byStringKey: "name")
        let suppliers = SupplierService().dictionary(byStringKey: "name")
        
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let count = try! self.persistentContainer.viewContext.count(for: fetchRequest)
        
        if count == 0 {
            let path = Bundle.main.path(forResource: "Products", ofType: "plist")
            let dataArray = NSArray(contentsOfFile: path!)!
            
            for dict in dataArray {
                let productDict = dict as! [String: String]
                let entity = Product(context: persistentContainer.viewContext)
                
                entity.name = productDict["name"]!
                if let tax =  taxes[ productDict["tax"]! ] as? Tax {
                    entity.tax = tax
                }
                
                if let supplier = suppliers[ productDict["supplier"]! ] as? Supplier {
                    entity.supplier = supplier
                }
            }
        }
        
        try! persistentContainer.viewContext.save()
    }
    
    
    fileprivate func loadStock() {
        
        let products = ProductService().dictionary(byStringKey: "name")

        let fetchRequest: NSFetchRequest<Stock> = Stock.fetchRequest()
        let count = try! self.persistentContainer.viewContext.count(for: fetchRequest)
        
        if count == 0 {
            let path = Bundle.main.path(forResource: "Stocks", ofType: "plist")
            let dataArray = NSArray(contentsOfFile: path!)!
            
            for dict in dataArray {
                let stockDict = dict as! [String: String]
                let entity = Stock(context: persistentContainer.viewContext)
                
                entity.quantity = NSDecimalNumber(string: stockDict["quantity"]!.replacingOccurrences(of: ",", with: "."))
                entity.reserved = NSDecimalNumber(string: "0")
                entity.unitNetPrice = NSDecimalNumber(string: stockDict["unitNetPrice"]!.replacingOccurrences(of: ",", with: "."))
                
                if let product =  products[ stockDict["product"]! ] as? Product {
                    entity.product = product
                }
                
            }
        }
        
        try! persistentContainer.viewContext.save()
    }
    
    
    
}

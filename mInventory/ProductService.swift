//
//  ProductService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 08.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class ProductService: NSManagedObjectService {
    
    init() {
        super.init(entityName: "Product", queryProperty: "name")
    }

    override func object(at: IndexPath) -> Product {
        return super.object(at: at) as! Product
    }

    func newInstance() -> Product {
        return Product(context: self.persistentContainer!.viewContext)
    }
}

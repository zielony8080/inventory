//
//  SupplierService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 09.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SupplierService: NSManagedObjectService {
    
    init() {
        super.init(entityName: "Supplier", queryProperty: "name")
    }
    
    override func object(at: IndexPath) -> Supplier {
        return super.object(at: at) as! Supplier
    }
    
    func newInstance() -> Supplier {
        return Supplier(context: self.persistentContainer!.viewContext)
    }
}

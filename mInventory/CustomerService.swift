//
//  CustomerService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 08.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class CustomerService : NSManagedObjectService {
    init() {
        super.init(entityName: "Customer", queryProperty: "name")
    }
    
    override func object(at: IndexPath) -> Customer {
        return super.object(at: at) as! Customer
    }
    
    func newInstance() -> Customer {
        return Customer(context: self.persistentContainer!.viewContext)
    }
    
}

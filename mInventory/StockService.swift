//
//  StoreService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 11.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class StockService : NSManagedObjectService {
    
    init() {
        super.init(entityName: "Stock", queryProperty: "product.name")
    }
    
    override func object(at: IndexPath) -> Stock {
        return super.object(at: at) as! Stock
    }
    
    func newInstance() -> Stock {
        return Stock(context: self.persistentContainer!.viewContext)
    }
}

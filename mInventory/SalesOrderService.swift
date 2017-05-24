//
//  SalesOrderService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 09.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SalesOrderService: NSManagedObjectService {

    init() {
        super.init(entityName: "SalesOrder", queryProperty: "number")
    }

    override func object(at: IndexPath) -> SalesOrder {
        return super.object(at: at) as! SalesOrder
    }
    
    func newInstance() -> SalesOrder {
        let salesOrder = SalesOrder(context: self.persistentContainer!.viewContext)
        salesOrder.status = "new"
        salesOrder.number = self.number(of: salesOrder)
        salesOrder.created = NSDate()
        salesOrder.active = true

        return salesOrder
    }
    
    func number(of salesOrder: SalesOrder?) -> String {
        
        if let salesOrder = salesOrder, let number = salesOrder.number {
            return number
        }
        let count = "\(super.countAll() + (salesOrder == nil ? 1 : 0))"
        let zeros = Array(repeating: "0", count: 5 - count.characters.count).joined(separator: "")
        let number = "SOR\(zeros)\(count)"
        
        return number
    }
    
    
}

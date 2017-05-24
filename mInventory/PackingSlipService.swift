//
//  PackingSlipService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 13.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class PackingSlipService: NSManagedObjectService {
    
    init() {
        super.init(entityName: "PackingSlip", queryProperty: "number")
    }
    
    override func object(at: IndexPath) -> PackingSlip {
        return super.object(at: at) as! PackingSlip
    }
    
    func newInstance(forSalesOrder salesOrder: SalesOrder) -> PackingSlip {
        let packingSlip = PackingSlip(context: self.persistentContainer!.viewContext)
        packingSlip.status = "new"
        packingSlip.number = self.number(of: packingSlip)
        packingSlip.created = NSDate()
        packingSlip.active = true

        packingSlip.salesOrder = salesOrder
        packingSlip.customer = salesOrder.customer

        let packingSlipPositionService = PackingSlipPositionService()
        
        for salesOrderPosition in salesOrder.positions! {
            if let salesOrderPosition = salesOrderPosition as? SalesOrderPosition {
                
                let position = packingSlipPositionService.newInstance()
                position.salesOrderPosition = salesOrderPosition
                position.quantity = NSDecimalNumber(string: "0")
                
                packingSlip.addToPositions(position)
            }
        }

        return packingSlip
    }
    
    func number(of packingSlip: PackingSlip?) -> String {
        
        if let packingSlip = packingSlip, let number = packingSlip.number {
            return number
        }
        let count = "\(super.countAll() + (packingSlip == nil ? 1 : 0))"
        let zeros = Array(repeating: "0", count: 5 - count.characters.count).joined(separator: "")
        let number = "PSL\(zeros)\(count)"
        
        return number
    }
}

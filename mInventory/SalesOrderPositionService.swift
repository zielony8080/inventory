//
//  SalesOrderPositionService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 11.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation

class SalesOrderPositionService : NSManagedObjectService {
    
    init() {
        super.init(entityName: "SalesOrderPosition", queryProperty: "")
    }
    
    override func object(at: IndexPath) -> SalesOrderPosition {
        return super.object(at: at) as! SalesOrderPosition
    }
    
    func newInstance(forSalesOrder salesOrder: SalesOrder) -> SalesOrderPosition {
        let salesOrderPosition = SalesOrderPosition(context: self.persistentContainer!.viewContext)
        
        let nextPositionNumber = 1 + (salesOrder.positions?.count ?? 0)
        salesOrderPosition.number = Int16(nextPositionNumber)

        return salesOrderPosition
    }
    
    
    
    
}

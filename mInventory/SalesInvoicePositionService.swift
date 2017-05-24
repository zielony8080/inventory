//
//  SalesInvoicePositionService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 17.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData

class SalesInvoicePositionService: NSManagedObjectService {

    init() {
        super.init(entityName: "SalesInvoicePosition", queryProperty: "invoice.number")
    }
    
    override func object(at: IndexPath) -> SalesInvoicePosition {
        return super.object(at: at) as! SalesInvoicePosition
    }
    
    func newInstance() -> SalesInvoicePosition {
        let salesInvoicePosition = SalesInvoicePosition(context: self.persistentContainer!.viewContext)
        return salesInvoicePosition
    }
}

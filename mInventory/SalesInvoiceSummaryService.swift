//
//  SalesInvoiceSummaryService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 18.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData

class SalesInvoiceSummaryService: NSManagedObjectService {
    
    init() {
        super.init(entityName: "SalesInvoiceSummary", queryProperty: "invoice.number")
    }
    
    override func object(at: IndexPath) -> SalesInvoiceSummary {
        return super.object(at: at) as! SalesInvoiceSummary
    }
    
    func newInstance() -> SalesInvoiceSummary {
        let salesInvoiceSummary = SalesInvoiceSummary(context: self.persistentContainer!.viewContext)
        return salesInvoiceSummary
    }
}

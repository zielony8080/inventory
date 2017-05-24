//
//  SalesInvoice+CoreDataClass.swift
//  mInventory
//
//  Created by Łukasz Zielony on 17.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


public class SalesInvoice: NSManagedObject {
    
    var orderredPositions : [SalesInvoicePosition] {
        get {
            let unorderedArray = positions?.allObjects as? [SalesInvoicePosition] ?? []
            return unorderedArray.sorted(by: {(lhs: SalesInvoicePosition, rhs: SalesInvoicePosition) -> Bool in
                return lhs.positionNo < rhs.positionNo
            })
        }
    }
    
    var orderredSummaries : [SalesInvoiceSummary] {
        get {
            let unorderedArray = summaries?.allObjects as? [SalesInvoiceSummary] ?? []
            return unorderedArray.sorted(by: {(lhs: SalesInvoiceSummary, rhs: SalesInvoiceSummary) -> Bool in
                return lhs.tax!.factor!.floatValue > rhs.tax!.factor!.floatValue
            })
        }
    }
    
}

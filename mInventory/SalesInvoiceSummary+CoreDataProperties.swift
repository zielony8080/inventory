//
//  SalesInvoiceSummary+CoreDataProperties.swift
//  mInventory
//
//  Created by Łukasz Zielony on 22.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


extension SalesInvoiceSummary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SalesInvoiceSummary> {
        return NSFetchRequest<SalesInvoiceSummary>(entityName: "SalesInvoiceSummary");
    }

    @NSManaged public var grossValue: NSDecimalNumber?
    @NSManaged public var netValue: NSDecimalNumber?
    @NSManaged public var taxValue: NSDecimalNumber?
    @NSManaged public var invoice: SalesInvoice?
    @NSManaged public var tax: Tax?

}

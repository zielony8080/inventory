//
//  SalesInvoicePosition+CoreDataProperties.swift
//  mInventory
//
//  Created by Łukasz Zielony on 22.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


extension SalesInvoicePosition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SalesInvoicePosition> {
        return NSFetchRequest<SalesInvoicePosition>(entityName: "SalesInvoicePosition");
    }

    @NSManaged public var grossValue: NSDecimalNumber?
    @NSManaged public var netValue: NSDecimalNumber?
    @NSManaged public var positionNo: Int16
    @NSManaged public var quantity: NSDecimalNumber?
    @NSManaged public var taxValue: NSDecimalNumber?
    @NSManaged public var unitNetValue: NSDecimalNumber?
    @NSManaged public var invoice: SalesInvoice?
    @NSManaged public var packingSlipPosition: PackingSlipPosition?

}

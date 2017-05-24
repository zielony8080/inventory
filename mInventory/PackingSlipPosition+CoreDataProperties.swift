//
//  PackingSlipPosition+CoreDataProperties.swift
//  mInventory
//
//  Created by Łukasz Zielony on 22.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


extension PackingSlipPosition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PackingSlipPosition> {
        return NSFetchRequest<PackingSlipPosition>(entityName: "PackingSlipPosition");
    }

    @NSManaged public var quantity: NSDecimalNumber?
    @NSManaged public var packingSlip: PackingSlip?
    @NSManaged public var salesInvoicePosition: SalesInvoicePosition?
    @NSManaged public var salesOrderPosition: SalesOrderPosition?

}

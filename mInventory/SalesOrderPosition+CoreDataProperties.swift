//
//  SalesOrderPosition+CoreDataProperties.swift
//  mInventory
//
//  Created by Łukasz Zielony on 22.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


extension SalesOrderPosition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SalesOrderPosition> {
        return NSFetchRequest<SalesOrderPosition>(entityName: "SalesOrderPosition");
    }

    @NSManaged public var number: Int16
    @NSManaged public var quantity: NSDecimalNumber?
    @NSManaged public var totalNetPrice: NSDecimalNumber?
    @NSManaged public var unitNetPrice: NSDecimalNumber?
    @NSManaged public var packingSlipPositions: NSSet?
    @NSManaged public var salesOrder: SalesOrder?
    @NSManaged public var stock: Stock?

}

// MARK: Generated accessors for packingSlipPositions
extension SalesOrderPosition {

    @objc(addPackingSlipPositionsObject:)
    @NSManaged public func addToPackingSlipPositions(_ value: PackingSlipPosition)

    @objc(removePackingSlipPositionsObject:)
    @NSManaged public func removeFromPackingSlipPositions(_ value: PackingSlipPosition)

    @objc(addPackingSlipPositions:)
    @NSManaged public func addToPackingSlipPositions(_ values: NSSet)

    @objc(removePackingSlipPositions:)
    @NSManaged public func removeFromPackingSlipPositions(_ values: NSSet)

}

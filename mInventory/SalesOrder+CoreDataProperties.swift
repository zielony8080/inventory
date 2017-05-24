//
//  SalesOrder+CoreDataProperties.swift
//  mInventory
//
//  Created by Łukasz Zielony on 22.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


extension SalesOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SalesOrder> {
        return NSFetchRequest<SalesOrder>(entityName: "SalesOrder");
    }

    @NSManaged public var active: Bool
    @NSManaged public var created: NSDate?
    @NSManaged public var number: String?
    @NSManaged public var status: String?
    @NSManaged public var customer: Customer?
    @NSManaged public var packingSlips: NSSet?
    @NSManaged public var positions: NSSet?

}

// MARK: Generated accessors for packingSlips
extension SalesOrder {

    @objc(addPackingSlipsObject:)
    @NSManaged public func addToPackingSlips(_ value: PackingSlip)

    @objc(removePackingSlipsObject:)
    @NSManaged public func removeFromPackingSlips(_ value: PackingSlip)

    @objc(addPackingSlips:)
    @NSManaged public func addToPackingSlips(_ values: NSSet)

    @objc(removePackingSlips:)
    @NSManaged public func removeFromPackingSlips(_ values: NSSet)

}

// MARK: Generated accessors for positions
extension SalesOrder {

    @objc(addPositionsObject:)
    @NSManaged public func addToPositions(_ value: SalesOrderPosition)

    @objc(removePositionsObject:)
    @NSManaged public func removeFromPositions(_ value: SalesOrderPosition)

    @objc(addPositions:)
    @NSManaged public func addToPositions(_ values: NSSet)

    @objc(removePositions:)
    @NSManaged public func removeFromPositions(_ values: NSSet)

}

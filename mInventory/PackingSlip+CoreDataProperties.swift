//
//  PackingSlip+CoreDataProperties.swift
//  mInventory
//
//  Created by Łukasz Zielony on 22.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


extension PackingSlip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PackingSlip> {
        return NSFetchRequest<PackingSlip>(entityName: "PackingSlip");
    }

    @NSManaged public var active: Bool
    @NSManaged public var created: NSDate?
    @NSManaged public var number: String?
    @NSManaged public var status: String?
    @NSManaged public var customer: Customer?
    @NSManaged public var positions: NSSet?
    @NSManaged public var salesOrder: SalesOrder?

}

// MARK: Generated accessors for positions
extension PackingSlip {

    @objc(addPositionsObject:)
    @NSManaged public func addToPositions(_ value: PackingSlipPosition)

    @objc(removePositionsObject:)
    @NSManaged public func removeFromPositions(_ value: PackingSlipPosition)

    @objc(addPositions:)
    @NSManaged public func addToPositions(_ values: NSSet)

    @objc(removePositions:)
    @NSManaged public func removeFromPositions(_ values: NSSet)

}

//
//  SalesInvoice+CoreDataProperties.swift
//  mInventory
//
//  Created by Łukasz Zielony on 22.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


extension SalesInvoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SalesInvoice> {
        return NSFetchRequest<SalesInvoice>(entityName: "SalesInvoice");
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var issueDate: NSDate?
    @NSManaged public var number: String?
    @NSManaged public var paymentDate: NSDate?
    @NSManaged public var status: String?
    @NSManaged public var customer: Customer?
    @NSManaged public var positions: NSSet?
    @NSManaged public var summaries: NSSet?

}

// MARK: Generated accessors for positions
extension SalesInvoice {

    @objc(addPositionsObject:)
    @NSManaged public func addToPositions(_ value: SalesInvoicePosition)

    @objc(removePositionsObject:)
    @NSManaged public func removeFromPositions(_ value: SalesInvoicePosition)

    @objc(addPositions:)
    @NSManaged public func addToPositions(_ values: NSSet)

    @objc(removePositions:)
    @NSManaged public func removeFromPositions(_ values: NSSet)

}

// MARK: Generated accessors for summaries
extension SalesInvoice {

    @objc(addSummariesObject:)
    @NSManaged public func addToSummaries(_ value: SalesInvoiceSummary)

    @objc(removeSummariesObject:)
    @NSManaged public func removeFromSummaries(_ value: SalesInvoiceSummary)

    @objc(addSummaries:)
    @NSManaged public func addToSummaries(_ values: NSSet)

    @objc(removeSummaries:)
    @NSManaged public func removeFromSummaries(_ values: NSSet)

}

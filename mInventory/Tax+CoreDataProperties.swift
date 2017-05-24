//
//  Tax+CoreDataProperties.swift
//  mInventory
//
//  Created by Łukasz Zielony on 22.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


extension Tax {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tax> {
        return NSFetchRequest<Tax>(entityName: "Tax");
    }

    @NSManaged public var factor: NSDecimalNumber?
    @NSManaged public var name: String?
    @NSManaged public var products: Product?
    @NSManaged public var summaries: NSSet?

}

// MARK: Generated accessors for summaries
extension Tax {

    @objc(addSummariesObject:)
    @NSManaged public func addToSummaries(_ value: SalesInvoiceSummary)

    @objc(removeSummariesObject:)
    @NSManaged public func removeFromSummaries(_ value: SalesInvoiceSummary)

    @objc(addSummaries:)
    @NSManaged public func addToSummaries(_ values: NSSet)

    @objc(removeSummaries:)
    @NSManaged public func removeFromSummaries(_ values: NSSet)

}

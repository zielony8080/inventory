//
//  Customer+CoreDataProperties.swift
//  mInventory
//
//  Created by Łukasz Zielony on 22.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer");
    }

    @NSManaged public var address: String?
    @NSManaged public var name: String?
    @NSManaged public var termOfPayment: Int16
    @NSManaged public var packingSlips: NSSet?
    @NSManaged public var salesOrders: NSSet?
    @NSManaged public var salesInvoices: NSSet?

}

// MARK: Generated accessors for packingSlips
extension Customer {

    @objc(addPackingSlipsObject:)
    @NSManaged public func addToPackingSlips(_ value: PackingSlip)

    @objc(removePackingSlipsObject:)
    @NSManaged public func removeFromPackingSlips(_ value: PackingSlip)

    @objc(addPackingSlips:)
    @NSManaged public func addToPackingSlips(_ values: NSSet)

    @objc(removePackingSlips:)
    @NSManaged public func removeFromPackingSlips(_ values: NSSet)

}

// MARK: Generated accessors for salesOrders
extension Customer {

    @objc(addSalesOrdersObject:)
    @NSManaged public func addToSalesOrders(_ value: SalesOrder)

    @objc(removeSalesOrdersObject:)
    @NSManaged public func removeFromSalesOrders(_ value: SalesOrder)

    @objc(addSalesOrders:)
    @NSManaged public func addToSalesOrders(_ values: NSSet)

    @objc(removeSalesOrders:)
    @NSManaged public func removeFromSalesOrders(_ values: NSSet)

}

// MARK: Generated accessors for salesInvoices
extension Customer {

    @objc(addSalesInvoicesObject:)
    @NSManaged public func addToSalesInvoices(_ value: SalesInvoice)

    @objc(removeSalesInvoicesObject:)
    @NSManaged public func removeFromSalesInvoices(_ value: SalesInvoice)

    @objc(addSalesInvoices:)
    @NSManaged public func addToSalesInvoices(_ values: NSSet)

    @objc(removeSalesInvoices:)
    @NSManaged public func removeFromSalesInvoices(_ values: NSSet)

}

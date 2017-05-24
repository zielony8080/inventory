//
//  Stock+CoreDataProperties.swift
//  mInventory
//
//  Created by Łukasz Zielony on 22.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


extension Stock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stock> {
        return NSFetchRequest<Stock>(entityName: "Stock");
    }

    @NSManaged public var quantity: NSDecimalNumber?
    @NSManaged public var reserved: NSDecimalNumber?
    @NSManaged public var unitNetPrice: NSDecimalNumber?
    @NSManaged public var product: Product?
    @NSManaged public var saleOrderPositions: NSSet?

}

// MARK: Generated accessors for saleOrderPositions
extension Stock {

    @objc(addSaleOrderPositionsObject:)
    @NSManaged public func addToSaleOrderPositions(_ value: SalesOrderPosition)

    @objc(removeSaleOrderPositionsObject:)
    @NSManaged public func removeFromSaleOrderPositions(_ value: SalesOrderPosition)

    @objc(addSaleOrderPositions:)
    @NSManaged public func addToSaleOrderPositions(_ values: NSSet)

    @objc(removeSaleOrderPositions:)
    @NSManaged public func removeFromSaleOrderPositions(_ values: NSSet)

}

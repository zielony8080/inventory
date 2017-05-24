//
//  Supplier+CoreDataProperties.swift
//  mInventory
//
//  Created by Łukasz Zielony on 22.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


extension Supplier {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Supplier> {
        return NSFetchRequest<Supplier>(entityName: "Supplier");
    }

    @NSManaged public var address: String?
    @NSManaged public var name: String?
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension Supplier {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

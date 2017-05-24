//
//  NSManagedObject+.swift
//  mInventory
//
//  Created by Łukasz Zielony on 09.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import CoreData

protocol DetailedEntity {
    var textLabel: String { get }
    var detailTextLabel: String { get }
}




extension Customer : DetailedEntity {
    var textLabel: String { return name ?? ""}
    var detailTextLabel: String { return address ?? "" }
}

extension Supplier : DetailedEntity {
    var textLabel: String { return name ?? ""}
    var detailTextLabel: String { return address ?? "" }
}

extension Product : DetailedEntity {
    var textLabel: String { return name ?? ""}
    var detailTextLabel: String { return "" }
}

extension Stock : DetailedEntity {
    var textLabel: String { return product?.name ?? "x"}
    var detailTextLabel: String { return "Total: \(quantity ?? 0), reserved: \(reserved ?? 0)" }
}

extension SalesOrder : DetailedEntity {
    var textLabel: String { return number ?? ""}
    var detailTextLabel: String { return customer?.name ?? "" }
}

extension PackingSlip : DetailedEntity {
    var textLabel: String { return number ?? ""}
    var detailTextLabel: String { return customer?.name ?? "" }
}


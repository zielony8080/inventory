//
//  Stock+CoreDataClass.swift
//  mInventory
//
//  Created by Łukasz Zielony on 11.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


public class Stock: NSManagedObject {

    var isEmpty : Bool {
        get {
            return quantity == nil || quantity! == NSDecimalNumber(value: 0)
        }
    }
}

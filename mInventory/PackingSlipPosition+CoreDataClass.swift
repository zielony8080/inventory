//
//  PackingSlipPosition+CoreDataClass.swift
//  mInventory
//
//  Created by Łukasz Zielony on 13.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


public class PackingSlipPosition: NSManagedObject {
    
    var isEmpty : Bool {
        get {
            return quantity == nil || quantity! == NSDecimalNumber(value: 0)
        }
    }

}

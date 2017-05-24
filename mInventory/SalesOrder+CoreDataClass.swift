//
//  SalesOrder+CoreDataClass.swift
//  mInventory
//
//  Created by Łukasz Zielony on 09.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


public class SalesOrder: NSManagedObject {

    var orderredPositions : [SalesOrderPosition] {
        get {
            
            let unorderedArray = positions?.allObjects as? [SalesOrderPosition] ?? []
            
            return unorderedArray.sorted(by: {(lhs: SalesOrderPosition, rhs: SalesOrderPosition) -> Bool in
                return lhs.number < rhs.number
            })
            
        }
    }

}

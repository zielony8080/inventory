//
//  PackingSlip+CoreDataClass.swift
//  mInventory
//
//  Created by Łukasz Zielony on 13.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData


public class PackingSlip: NSManagedObject {

    var isEditable : Bool {
        let service = PackingSlipTransitionService(packingSlip: self)
        return service.attribute(self, attributeName: "editable", ofValue: "true")
    }
    
    
    var orderredArray : [PackingSlipPosition] {
        get {

            let unorderedArray = positions?.allObjects as? [PackingSlipPosition] ?? []
            
            return unorderedArray.sorted(by: {(lhs: PackingSlipPosition, rhs: PackingSlipPosition) -> Bool in
                let lhsNumber = lhs.salesOrderPosition?.number ?? 0
                let rhsNumber = rhs.salesOrderPosition?.number ?? 0
                
                return lhsNumber < rhsNumber
            })

        }
    }
}

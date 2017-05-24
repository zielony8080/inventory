//
//  TransitionService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 16.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData

class TransitionService: NSObject {
    fileprivate var transferable: Transferable!
    
    internal var salesOrder: SalesOrder?
    internal var packingSlip: PackingSlip?
    
    init(transferable: Transferable) {
        self.transferable = transferable
        
        salesOrder = transferable as? SalesOrder
        packingSlip = transferable as? PackingSlip
    }
    
    func attribute(_ transferable: Transferable, attributeName: String, ofValue: String) -> Bool {
        for attribute in TransitionManager.attributes(of: transferable) {
            if attribute.name == attributeName {
                return ofValue == attribute.value
            }
        }
        
        return false
    }

    
    

    func transit(to: String) {
        transferable.status = to
    }
}

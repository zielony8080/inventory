//
//  PackingSlipPositionService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 13.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation

class PackingSlipPositionService : NSManagedObjectService {
    
    init() {
        super.init(entityName: "PackingSlipPosition", queryProperty: "")
    }
    
    override func object(at: IndexPath) -> PackingSlipPosition {
        return super.object(at: at) as! PackingSlipPosition
    }
    
    func newInstance() -> PackingSlipPosition {
        let packingSlipPosition = PackingSlipPosition(context: self.persistentContainer!.viewContext)
        return packingSlipPosition
    }

}

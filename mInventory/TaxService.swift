//
//  TaxService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 08.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class TaxService : NSManagedObjectService {

    init() {
        super.init(entityName: "Tax", queryProperty: "name")
    }

    override func object(at: IndexPath) -> Tax {
        return super.object(at: at) as! Tax
    }

    func newInstance() -> Tax {
        return Tax(context: self.persistentContainer!.viewContext)
    }
}

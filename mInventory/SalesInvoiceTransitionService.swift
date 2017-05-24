//
//  SalesInvoiceTransitionService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 17.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation

class SalesInvoiceTransitionService: TransitionService {
    
    init(salesInvoice: SalesInvoice) {
        super.init(transferable: salesInvoice)
    }
    
    
    func finishInvoice() {
        print ("finish invoice")
    }
}

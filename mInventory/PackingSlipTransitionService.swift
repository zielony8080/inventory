//
//  PackingSlipTransitionService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 16.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation

class PackingSlipTransitionService: TransitionService {

    init(packingSlip: PackingSlip) {
        super.init(transferable: packingSlip)
    }

    func releaseProducts() {
        guard let packingSlip = super.packingSlip else {
            return
        }
        
        for position in packingSlip.positions! {
            if let packingSlipPosition = position as? PackingSlipPosition {
                let salesOrderPosition = packingSlipPosition.salesOrderPosition!
                let stock = salesOrderPosition.stock!
                
                let toRelease = packingSlipPosition.quantity!
                
                salesOrderPosition.quantity = salesOrderPosition.quantity?.subtracting(toRelease)
                stock.reserved = stock.reserved?.subtracting(toRelease)
            }
        }
    }


}

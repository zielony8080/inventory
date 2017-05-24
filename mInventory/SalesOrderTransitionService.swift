//
//  SalesOrderTransitionService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 12.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData

class SalesOrderTransitionService: TransitionService {

    init(salesOrder: SalesOrder) {
        super.init(transferable: salesOrder)
    }
    
    func validateReservation() -> TransitionConditionMessage {
        guard let salesOrder = super.salesOrder else {
            return TransitionConditionMessage(status: "ERROR", message: "no context")
        }
        
        for position in salesOrder.positions! {
            if let salesOrderPosition = position as? SalesOrderPosition {
                if let stock = salesOrderPosition.stock {
                    let need = salesOrderPosition.quantity
                    let thereIs = stock.quantity
                    
                    if need!.floatValue > thereIs!.floatValue {
                        return TransitionConditionMessage(status: "ERROR", message: "no product")
                    }
                }
            }
        }

        return TransitionConditionMessage(status: "OK", message: "")
    }
    
    func reserveProducts() {
        guard let salesOrder = super.salesOrder else {
            return
        }
        
        for position in salesOrder.positions! {
            if let salesOrderPosition = position as? SalesOrderPosition {
                if let stock = salesOrderPosition.stock {
                    let toTake = salesOrderPosition.quantity
                    
                    stock.quantity = stock.quantity?.subtracting(toTake!)
                    stock.reserved = stock.reserved?.adding(toTake!)
                }
            }
        }
        
        StockService().save()
    }

    func salesOrder(_ salesOrder: SalesOrder, attributeName: String, ofValue: String) -> Bool {
        for attribute in TransitionManager.attributes(of: salesOrder) {
            if attribute.name == attributeName {
                return ofValue == attribute.value
            }
        }
        
        return false
    }
    
}

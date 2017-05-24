//
//  TransitionManager.swift
//  mInventory
//
//  Created by Łukasz Zielony on 12.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData

class TransitionManager {
    
    fileprivate static var byDocument: [String:[DocumentState]] = [:]
    
    static func transitions(for transferable: Transferable?) -> [String] {
        if let transferable = transferable, let statuses = byDocument[transferable.documentName]{
            if let status = statuses.filter({$0.name == transferable.status!}).first {
                return status.transitions.map({$0.name})
            }
        }
        
        return []
    }

    fileprivate static func transition(transferable: Transferable, from fromState: String, to toState: String) -> DocumentTransition? {
        if let states = byDocument[transferable.documentName]{
            if let status = states.filter({$0.name == fromState}).first {
                return status.transitions.filter({$0.name == toState}).first
            }
        }
        return nil
    }

    static func transit(transferable: Transferable, to state: String) {
        if let transition = TransitionManager.transition(transferable: transferable, from: transferable.status!, to: state) {
            var service: TransitionService = TransitionService(transferable: transferable)
            
            if let salesOrder = transferable as? SalesOrder {
                service = SalesOrderTransitionService(salesOrder: salesOrder)
            } else if let packingSlip = transferable as? PackingSlip {
                service = PackingSlipTransitionService(packingSlip: packingSlip)
            } else if let salesInvoice = transferable as? SalesInvoice {
                service = SalesInvoiceTransitionService(salesInvoice: salesInvoice)
            }

//            if let condition = transition.condition {
//                let conditionSelector : Selector = NSSelectorFromString(condition)
//
//                let returnValue: Unmanaged<AnyObject> = service.perform(conditionSelector)
//                let status : TransitionConditionMessage? = returnValue.takeRetainedValue() as? TransitionConditionMessage
//                if !status!.isCorrect {
//                    service.transit(to: transition.failureTransition!)
//                    return
//                }
//            }
            
            service.transit(to: state)
            if let action = transition.action {
                let selector : Selector = NSSelectorFromString(action)
                service.perform(selector)
            }
        }
    }

    static func attributes(of: Transferable) -> [DocumentAttribute] {
        if let salesOrderStates = byDocument[of.documentName]{
            if let status = salesOrderStates.filter({$0.name == of.status}).first {
                return status.attributes
            }
        }
        return []
    }
    
    static func loadTransitions() {
        let parser = TransitionXmlParser()
        let states = parser.parse()
        for state in states {
            let document = state.document
            if byDocument[document] == nil {
                byDocument[document] = []
            }
            byDocument[document]?.append(state)
        }
    }

    

}

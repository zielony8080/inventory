//
//  Transferable.swift
//  mInventory
//
//  Created by Łukasz Zielony on 16.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation

@objc protocol Transferable {
    var status : String? {get set}
    var documentName: String {get}
}

extension SalesOrder: Transferable {
    var documentName: String {
        get {
            return "SalesOrder"
        }
    }
}

extension PackingSlip: Transferable {
    var documentName: String {
        get {
            return "PackingSlip"
        }
    }
}

extension SalesInvoice: Transferable {
    var documentName: String {
        get {
            return "SalesInvoice"
        }
    }
}


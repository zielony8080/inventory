//
//  Calculator.swift
//  mInventory
//
//  Created by Łukasz Zielony on 11.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation

class PriceService {
    
    static func parse(value: Any?) -> NSDecimalNumber? {
        if value == nil {
            return nil
        } else if let decimalNumber = value as? NSDecimalNumber {
            return decimalNumber
        } else if let string = value as? String {
            let decimalNumber = NSDecimalNumber(string: string)
            if !decimalNumber.doubleValue.isNaN {
                return decimalNumber
            }
        } else {
            print ("PriceService.parse [input type error] value: \(value)")
        }
        
        
        return nil
    }
    
    
    static func multiplay(lhs: Any?, rhs: Any?) -> NSDecimalNumber? {
        let lhsValue : NSDecimalNumber? = PriceService.parse(value: lhs)
        let rhsValue : NSDecimalNumber? = PriceService.parse(value: rhs)
        
        if lhsValue == nil || rhsValue == nil {
            return nil
        }
        
        return lhsValue!.multiplying(by: rhsValue!)
    }
    
    
    static func format(price value: String?) -> String {
        guard value != nil else { return "$0.00" }
        let doubleValue = Double(value!) ?? 0.0
        let formatter = NumberFormatter()
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = (value!.contains(".00")) ? 0 : 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currencyAccounting
        return formatter.string(from: NSNumber(value: doubleValue)) ?? "$\(doubleValue)"
    }
    
    
    
}

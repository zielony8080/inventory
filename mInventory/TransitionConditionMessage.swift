//
//  TransitionConditionMessage.swift
//  mInventory
//
//  Created by Łukasz Zielony on 16.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation

class TransitionConditionMessage: NSObject {
    var status: String
    var message: String
    
    init(status: String, message: String) {
        self.status = status
        self.message = message
    }

    var isCorrect: Bool {
        get {
            return status == "OK"
        }
    }
}

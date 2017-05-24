//
//  Transition.swift
//  mInventory
//
//  Created by Łukasz Zielony on 12.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation

class DocumentTransition {
    var name: String = ""
    var action: String?
    var condition: String?
    var failureTransition: String?
}

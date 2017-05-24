//
//  DocumentState.swift
//  mInventory
//
//  Created by Łukasz Zielony on 12.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation

class DocumentState {
    var name: String = ""
    var document: String = ""
    
    var transitions: [DocumentTransition] = []
    var attributes: [DocumentAttribute] = []
}

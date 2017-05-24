//
//  String+.swift
//  mInventory
//
//  Created by Łukasz Zielony on 11.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation

extension String {
    
    public func convertRange(range: Range<Int>) -> Range<String.Index> {
        let start = characters.index(startIndex, offsetBy: range.lowerBound)
        let end =  characters.index(start, offsetBy: range.upperBound - range.lowerBound)
        return Range(start ..< end)
    }   


}

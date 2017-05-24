//
//  UITableViewCell+.swift
//  mInventory
//
//  Created by Łukasz Zielony on 18.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    func configure(with entity: DetailedEntity?) {
        if entity != nil {
            self.textLabel?.text = entity!.textLabel
            self.detailTextLabel?.text = entity!.detailTextLabel
        }
    }

}

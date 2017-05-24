//
//  StatusTableViewCell.swift
//  mInventory
//
//  Created by Łukasz Zielony on 12.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var changeStateButton: UIButton!
    
    var onChangeStatus : (() -> ())!

    @IBAction func changeStatus(_ sender: Any) {
        onChangeStatus()
    }
    
    var active: Bool? {
        didSet {
            changeStateButton.isEnabled = active ?? false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

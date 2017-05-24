//
//  SalesInvoiceSummaryViewCell.swift
//  mInventory
//
//  Created by Łukasz Zielony on 18.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SalesInvoiceSummaryViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var netValueSummaryLabel: UILabel!
    @IBOutlet weak var taxValueSummaryLable: UILabel!
    @IBOutlet weak var grossValueSummaryLabel: UILabel!
    
    var salesInvoiceSummary : SalesInvoiceSummary! {
        didSet {
            let tax = salesInvoiceSummary.tax!
            
            let netValue = PriceService.format(price: salesInvoiceSummary.netValue?.stringValue)
            let taxValue = PriceService.format(price: salesInvoiceSummary.taxValue?.stringValue)
            let grossValue = PriceService.format(price: salesInvoiceSummary.grossValue?.stringValue)
            
            positionLabel.text = "\(tax.name!)"
            netValueSummaryLabel.text = "\(netValue)"
            taxValueSummaryLable.text = "\(taxValue)"
            grossValueSummaryLabel.text = "\(grossValue)"
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

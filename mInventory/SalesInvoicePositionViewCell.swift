//
//  SalesInvoicePositionViewCell.swift
//  mInventory
//
//  Created by Łukasz Zielony on 18.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SalesInvoicePositionViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var netValueSummaryLabel: UILabel!
    @IBOutlet weak var taxValueSummaryLable: UILabel!
    @IBOutlet weak var grossValueSummaryLabel: UILabel!
 
    var salesInvoicePosition : SalesInvoicePosition! {
        didSet {
            let packingSlipPosition = salesInvoicePosition.packingSlipPosition!
            let salesOrderPosition = packingSlipPosition.salesOrderPosition!
            let product = salesOrderPosition.stock!.product!
            let tax = product.tax!.name!

            let unitNetValue = PriceService.format(price: salesInvoicePosition.unitNetValue?.stringValue)
            let netValue = PriceService.format(price: salesInvoicePosition.netValue?.stringValue)
            let quantity = salesOrderPosition.quantity!.stringValue
            let taxValue = PriceService.format(price: salesInvoicePosition.taxValue?.stringValue)
            let grossValue = PriceService.format(price: salesInvoicePosition.grossValue?.stringValue)

            positionLabel.text = " \(salesInvoicePosition.positionNo). \(product.name!)"
            netValueSummaryLabel.text = "\(unitNetValue) x \(quantity) = \(netValue)"
            taxValueSummaryLable.text = "\(netValue) x \(tax) = \(taxValue)"
            grossValueSummaryLabel.text = "\(netValue) + \(taxValue) = \(grossValue)"
            
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

//
//  SalesReportViewCell.swift
//  mInventory
//
//  Created by Łukasz Zielony on 18.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SalesReportViewCell: UITableViewCell {

    @IBOutlet weak var documentLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    var salesInvoicePosition: SalesInvoicePosition! {
        didSet {

            let invoice = salesInvoicePosition.invoice!
            let customer = invoice.customer!
            let packingSlipPosition = salesInvoicePosition.packingSlipPosition!
            let salesOrderPosition = packingSlipPosition.salesOrderPosition!
            let stock = salesOrderPosition.stock!
            let product = stock.product!

            documentLabel.text = "\(invoice.number)"
            customerLabel.text = "\(customer.name)"
            productLabel.text = "\(product.name)"
            valueLabel.text = "\(PriceService.format(price: salesInvoicePosition.netValue?.stringValue))"
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

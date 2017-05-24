//
//  PackingSlipViewCell.swift
//  mInventory
//
//  Created by Łukasz Zielony on 13.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class PackingSlipPositionViewCell: UITableViewCell {

    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var quantitySlider: UISlider!

    var packingSlipPosition : PackingSlipPosition? {
        didSet {
            let stock = packingSlipPosition?.salesOrderPosition?.stock
            productLabel.text = "\(packingSlipPosition!.salesOrderPosition!.number). \(stock?.product?.name ?? "")"

            if stock!.isEmpty {
                quantitySlider.minimumValue = Float(0.0)
                quantitySlider.maximumValue = Float(0.0)
                quantitySlider.value = Float(0.0)
                
            } else {
                quantitySlider.minimumValue = Float(0.0)
                quantitySlider.maximumValue = Float(packingSlipPosition?.salesOrderPosition?.quantity ?? 1)
                quantitySlider.value = Float(packingSlipPosition?.quantity ?? 0)
            }

            self.redrawSummary()
        }
    }
    
    @IBAction func onSliderChanged(_ sender: UISlider) {
        let floatValue = Float(lroundf(quantitySlider.value))
        packingSlipPosition?.quantity = NSDecimalNumber(value: floatValue)
        sender.setValue(floatValue, animated: true)
        
        redrawSummary()
    }

    fileprivate func redrawSummary() {
        let stock = packingSlipPosition?.salesOrderPosition?.stock
        let net = stock!.unitNetPrice
        let quantity = NSDecimalNumber(value: quantitySlider.value)
        let total = PriceService.multiplay(lhs: net, rhs: quantity)
        
        let netDescription = PriceService.format(price: net?.stringValue)
        let quantityDescription = quantity.stringValue
        let totalDescription = PriceService.format(price: total?.stringValue)
        
        summaryLabel.text = "\(netDescription) x \(quantityDescription) = \(totalDescription)"
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

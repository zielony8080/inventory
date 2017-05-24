//
//  QuantityTableViewCell.swift
//  mInventory
//
//  Created by Łukasz Zielony on 11.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class QuantityTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var unitNetPriceTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var quantitySlider: UISlider!
    @IBOutlet weak var taxTextField: UITextField!
    @IBOutlet weak var totalNetPriceTextField: UITextField!

    fileprivate var net: NSDecimalNumber = NSDecimalNumber(value: 0)
    fileprivate var quantity: NSDecimalNumber = NSDecimalNumber(value: 0)
    fileprivate var total: NSDecimalNumber = NSDecimalNumber(value: 0)
    fileprivate var min: NSDecimalNumber = NSDecimalNumber(value: 0)
    fileprivate var max: NSDecimalNumber = NSDecimalNumber(value: 0)

    var stock: Stock? {
        didSet {
            if let stock = stock {
                self.net = stock.unitNetPrice ?? NSDecimalNumber(value: 0)
                self.min = stock.isEmpty ? NSDecimalNumber(value: 0) : NSDecimalNumber(value: 1)
                self.max = stock.quantity ?? NSDecimalNumber(value: 0)
                self.total = PriceService.multiplay(lhs: net, rhs: quantity)!

                unitNetPriceTextField.text = PriceService.format(price: self.net.stringValue)

                quantitySlider.minimumValue = Float(self.min)
                quantitySlider.maximumValue = Float(self.max)
                quantitySlider.value = Float(self.quantity)
                
                salesOrderPosition?.quantity = NSDecimalNumber(value: quantitySlider.value)
                quantityTextField.text =  salesOrderPosition?.quantity?.stringValue ?? ""

                taxTextField.text = stock.product?.tax?.name ?? ""
                totalNetPriceTextField.text = PriceService.format(price: self.total.stringValue)
            }
        }
    }
    
    var salesOrderPosition : SalesOrderPosition? {
        didSet {
            if let position = salesOrderPosition, let stock = position.stock {
                self.quantity = position.quantity ?? NSDecimalNumber(value: stock.isEmpty ? 0 : 1)
                self.stock = stock
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        quantityTextField.delegate = self
    }

    @IBAction func onSliderChanged(_ sender: UISlider) {
        let floatValue = Float(lroundf(quantitySlider.value))

        sender.setValue(floatValue, animated: true)
        quantityTextField.text = String( Int(sender.value) )

        self.quantity = NSDecimalNumber(value: floatValue)
        self.total = PriceService.multiplay(lhs: net, rhs: quantity)!
        
        totalNetPriceTextField.text = PriceService.format(price: self.total.stringValue)
    }

    @IBAction func onTextFieldChanged(_ sender: UITextField) {
        if let value = sender.text {
            let floatValue = Float(value) ?? 0
            quantitySlider.setValue(floatValue, animated: true)
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        
        if string == numberFiltered {
            if let text = quantityTextField?.text {
                let indexRange = text.convertRange(range: range.toRange()!)
                let newValue = text.replacingCharacters(in: indexRange, with: string)
                quantitySlider.setValue(Float(newValue) ?? 0, animated: true)
            }
            return true
        }
        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


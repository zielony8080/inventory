//
//  SalesInvoiceService.swift
//  mInventory
//
//  Created by Łukasz Zielony on 17.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation
import CoreData

class SalesInvoiceService: NSManagedObjectService {

    let invoicePositionSevice = SalesInvoicePositionService()
    let invoiceSummaryService = SalesInvoiceSummaryService()
    
    
    init() {
        super.init(entityName: "SalesInvoice", queryProperty: "number")
    }
    
    override func object(at: IndexPath) -> SalesInvoice {
        return super.object(at: at) as! SalesInvoice
    }
    
    func newInstance(packingSlip: PackingSlip) -> SalesInvoice {

        let salesInvoice = SalesInvoice(context: self.persistentContainer!.viewContext)
        salesInvoice.status = "new"
        salesInvoice.number = self.number(of: salesInvoice)
        salesInvoice.customer = packingSlip.customer

        salesInvoice.created = NSDate()
        salesInvoice.issueDate = NSDate()
        salesInvoice.paymentDate =  Calendar.current.date(byAdding: .day, value: Int(salesInvoice.customer!.termOfPayment), to: salesInvoice.issueDate! as Date)! as NSDate

        class TaxSummary {
            var tax: Tax
            var netValue: NSDecimalNumber = NSDecimalNumber(value: 0)
            var taxValue: NSDecimalNumber = NSDecimalNumber(value: 0)
            var grossValue: NSDecimalNumber = NSDecimalNumber(value: 0)
          
            init (tax: Tax) {
                self.tax = tax
            }

            func add(position: SalesInvoicePosition) {
                netValue = netValue.adding(position.netValue!)
                taxValue = taxValue.adding(position.taxValue!)
                grossValue = grossValue.adding(position.grossValue!)
            }
        }
        
        var summary: [Tax:TaxSummary] = [:]

        var positionNo: Int16 = 0
        
        for position in packingSlip.orderredArray {
            positionNo += 1
            
            let invoicePosition = invoicePositionSevice.newInstance()
            invoicePosition.positionNo = positionNo
            invoicePosition.packingSlipPosition = position
            
            let tax = position.salesOrderPosition!.stock!.product!.tax!

            invoicePosition.unitNetValue = position.salesOrderPosition?.unitNetPrice
            invoicePosition.quantity = position.quantity
            
            invoicePosition.netValue = PriceService.multiplay(lhs: invoicePosition.unitNetValue, rhs: invoicePosition.quantity)
            invoicePosition.taxValue = PriceService.multiplay(lhs: invoicePosition.netValue, rhs: tax.factor)
            invoicePosition.grossValue = invoicePosition.netValue!.adding(invoicePosition.taxValue!)

            salesInvoice.addToPositions(invoicePosition)

            if summary[tax] == nil {
                summary[tax] = TaxSummary(tax: tax)
            }
            
            summary[tax]!.add(position: invoicePosition)
        }
        
        for (tax, taxSummary) in summary {
            let invoiceSummary = invoiceSummaryService.newInstance()
            
            invoiceSummary.tax = tax
            invoiceSummary.netValue = taxSummary.netValue
            invoiceSummary.taxValue = taxSummary.taxValue
            invoiceSummary.grossValue = taxSummary.grossValue
            
            salesInvoice.addToSummaries(invoiceSummary)
        }

        return salesInvoice
    }
  
    
    func number(of salesInvoice: SalesInvoice?) -> String {
        
        if let salesInvoice = salesInvoice, let number = salesInvoice.number {
            return number
        }
        let count = "\(super.countAll() + (salesInvoice == nil ? 1 : 0))"
        let zeros = Array(repeating: "0", count: 5 - count.characters.count).joined(separator: "")
        let number = "SIN\(zeros)\(count)"
        
        return number
    }

    
    
}

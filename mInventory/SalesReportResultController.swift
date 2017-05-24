//
//  SalesReportResultController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 18.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SalesReportResultController: UITableViewController {

    var salesInvoicePositionService = SalesInvoicePositionService()
    
    var customer: Customer?
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var predicates: [NSPredicate] = []

        if let customer = customer {
            predicates.append(NSPredicate(format: "invoice.customer.name == %@", customer.name!))
        }
        
        if let product = product {
            predicates.append(NSPredicate(format: "packingSlipPosition.salesOrderPosition.stock.product.name == %@", product.name!))
        }

        salesInvoicePositionService.findBy(predicates: predicates)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salesInvoicePositionService.count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("SalesReportViewCell", owner: self, options: nil)?.first as! SalesReportViewCell
        let salesInvoicePosition = salesInvoicePositionService.object(at: indexPath)
        cell.salesInvoicePosition = salesInvoicePosition

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }

}

//MARK: - UITableViewDataSource
extension SalesReportResultController {
    
}


//
//  SalesOrderPositionViewController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 10.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SalesOrderPositionViewController: UITableViewController {

    @IBOutlet weak var productTableViewCell: UITableViewCell!
    @IBOutlet weak var quantityTableViewCell: QuantityTableViewCell!

    var salesOrderPositionService = SalesOrderPositionService()
    
    var salesOrderPosition: SalesOrderPosition?
    var salesOrder: SalesOrder!
    var stock: Stock?
    var refreshable: RefreshableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(SupplierViewController.save(_:)))
        navigationItem.rightBarButtonItems = [saveBarButtonItem]

        self.stock = salesOrderPosition?.stock
        if self.stock != nil {
            onProductSelected(self.stock)
        }
    }
    
    func onProductSelected(_ stock: NSManagedObject?) {
        self.stock = stock as? Stock
        self.salesOrderPosition?.stock = self.stock
        
        productTableViewCell.detailTextLabel?.text = self.stock?.product?.name ?? ""

        if self.salesOrderPosition == nil {
            quantityTableViewCell.stock = self.stock
        } else {
            quantityTableViewCell.salesOrderPosition = self.salesOrderPosition
        }
    }

    func save(_ sender: UIBarButtonItem) {
        if stock == nil {
            AlertController.info(title: "Validation error!", message: "Product is required", inController: self)
            return
        }

        guard let quantity = PriceService.parse(value: quantityTableViewCell.quantityTextField?.text) else {
            AlertController.info(title: "Validation error!", message: "Quantity is required", inController: self)
            return
        }
        
        if salesOrderPosition == nil {
            salesOrderPosition = salesOrderPositionService.newInstance(forSalesOrder: salesOrder)
        }

        salesOrderPosition!.stock = stock
        salesOrderPosition!.salesOrder = salesOrder
        
        salesOrderPosition!.unitNetPrice = stock?.unitNetPrice
        salesOrderPosition!.quantity = quantity
        salesOrderPosition!.totalNetPrice = PriceService.multiplay(lhs: salesOrderPosition!.unitNetPrice, rhs: salesOrderPosition!.quantity)
        
        
        salesOrderPositionService.save()
        
        let _ = navigationController?.popViewController(animated: true)
        refreshable?.refresh()
    }

}

// MARK: - UITableViewDelegate
extension SalesOrderPositionViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.reuseIdentifier == "Product" {
            let controller = storyboard!.instantiateViewController(withIdentifier: "SelectNSManagedObjectController") as! SelectNSManagedObjectController
            controller.modalPresentationStyle = .popover
            controller.modalTransitionStyle = .coverVertical
            controller.onSelectFunction = onProductSelected(_:)

            
            var forbiddenProducts = salesOrder!.orderredPositions
                .map({$0.stock!.product!})
            
            if let currentProduct = salesOrderPosition?.stock?.product {
                forbiddenProducts = forbiddenProducts.filter({$0 != currentProduct})
            }

            if !forbiddenProducts.isEmpty {
                let predicates: [NSPredicate] = forbiddenProducts
                    .map({NSPredicate(format: "product.name != %@", $0.name!)})
                
                controller.searchPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            }
            
            controller.service = StockService()
            
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let position = salesOrderPosition {
            return "POSITION  #\(position.number)"
        } else {
            let nextPositionNumber = 1 + (salesOrder.positions?.count ?? 0)
            return "POSITION  #\(nextPositionNumber)"
        }
    }
    
   
}

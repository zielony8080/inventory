//
//  SalesOrderViewController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 09.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SalesOrderViewController: UITableViewController, RefreshableDelegate {

    @IBOutlet weak var numberTableViewCell: UITableViewCell!
    @IBOutlet weak var dateTableViewCell: UITableViewCell!
    @IBOutlet weak var statusTableViewCell: UITableViewCell!
    @IBOutlet weak var customerTableViewCell: UITableViewCell!

    var addPositionTableViewCell: UITableViewCell = UITableViewCell()

    var customer : Customer?
    var salesOrder : SalesOrder?
    var salesOrderService = SalesOrderService()

    var refreshable: RefreshableDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(SupplierViewController.save(_:)))
        navigationItem.rightBarButtonItems = [saveBarButtonItem]

        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium

        self.dateTableViewCell.detailTextLabel?.text = formatter.string(from: salesOrder?.created as? Date ?? Date())
        self.numberTableViewCell.detailTextLabel?.text = salesOrderService.number(of: salesOrder)
        
        self.customer = salesOrder?.customer
        self.customerTableViewCell.textLabel?.text = customer?.name ?? "Select customer"
        self.customerTableViewCell.detailTextLabel?.text = customer?.address ?? ""
    }

    func refresh() {
        tableView.reloadData()
    }
    
    func save(_ sender: UIBarButtonItem) {
        if customer == nil {
            AlertController.info(title: "Validation error!", message: "Customer is required", inController: self)
            return
        }

        if salesOrder == nil {
            salesOrder = salesOrderService.newInstance()
            salesOrder!.customer = customer
            salesOrderService.save()
            tableView.reloadData()
        } else {
            salesOrder!.customer = customer
            salesOrderService.save()
            refreshable?.refresh()
            let _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func changeStatus() {
        let alertController = UIAlertController(title: "Select new stauts", message: "", preferredStyle: .actionSheet)

        for status in TransitionManager.transitions(for: salesOrder) {
            let changeStatusAction = UIAlertAction(title: "\(status)", style: .default, handler: {(alert: UIAlertAction!) in
                TransitionManager.transit(transferable: self.salesOrder!, to: status)

                self.refresh()
                self.refreshable?.refresh()
                
                let _ = self.navigationController?.popViewController(animated: true)
            })
            alertController.addAction(changeStatusAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }


}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SalesOrderViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 2 {
            
            let cell = Bundle.main.loadNibNamed("StatusTableViewCell", owner: self, options: nil)?.first as! StatusTableViewCell
            if let salesOrder = salesOrder {
                cell.statusLabel.text = salesOrder.status
            }
            
            cell.onChangeStatus = changeStatus
            cell.active = !TransitionManager.transitions(for: salesOrder).isEmpty
            return cell
        }
        
        if indexPath.section == 2 {
            
            if indexPath.row == salesOrder?.positions?.count {
                addPositionTableViewCell.textLabel?.text = "Add new position..."
                return addPositionTableViewCell
            } else if let position = salesOrder?.orderredPositions[indexPath.row] {
                let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Position\(position.number)")
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.text = "\(position.number). \(position.stock?.product?.name ?? "")"
                cell.detailTextLabel?.text = PriceService.format(price: position.totalNetPrice?.stringValue)
                return cell
            }
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell == addPositionTableViewCell || cell?.reuseIdentifier?.hasPrefix("Position") ?? false {
            let controller = storyboard!.instantiateViewController(withIdentifier: "SalesOrderPositionViewController") as! SalesOrderPositionViewController
            controller.modalPresentationStyle = .popover
            controller.modalTransitionStyle = .coverVertical
            controller.salesOrder = salesOrder
            controller.refreshable = self

            if cell?.reuseIdentifier?.hasPrefix("Position") ?? false {
                if let position = salesOrder?.orderredPositions[indexPath.row] {
                    controller.salesOrderPosition = position
                }
            }

            navigationController?.pushViewController(controller, animated: true)

        } else if let id = cell?.reuseIdentifier, ["Customer"].contains(id) {
            let controller = storyboard!.instantiateViewController(withIdentifier: "SelectNSManagedObjectController") as! SelectNSManagedObjectController
            controller.modalPresentationStyle = .popover
            controller.modalTransitionStyle = .coverVertical
            
            if id == "Customer" {
                controller.onSelectFunction = { (customer: NSManagedObject?) -> () in
                    self.customer = customer as? Customer
                    self.customerTableViewCell.textLabel?.text = self.customer?.name ?? "Select customer"
                    self.customerTableViewCell.detailTextLabel?.text = self.customer?.address ?? ""
                }

                controller.service = CustomerService()
            }
            
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return super.numberOfSections(in: tableView) - (salesOrder == nil ? 1 : 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && salesOrder == nil {
            let number = super.tableView(tableView, numberOfRowsInSection: section) - 1
            return number
        } else if section == 2 {
            let number = 1 + (salesOrder?.positions?.count ?? 0)
            return number
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    

}


//
//  SalesInvoieceViewController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 17.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SalesInvoieceViewController: UITableViewController {

    @IBOutlet weak var numberTableViewCell: UITableViewCell!
    @IBOutlet weak var customerTableViewCell: UITableViewCell!
    @IBOutlet weak var statusTableViewCell: UITableViewCell!
    @IBOutlet weak var issueDateTableViewCell: UITableViewCell!
    @IBOutlet weak var paymentDayTableViewCell: UITableViewCell!

    var salesInvoice: SalesInvoice!
    var refreshable: RefreshableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numberTableViewCell.detailTextLabel?.text = salesInvoice.number ?? ""
        customerTableViewCell.detailTextLabel?.text = salesInvoice.customer?.name ?? ""
        statusTableViewCell.detailTextLabel?.text = salesInvoice.status ?? ""

        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium

        self.issueDateTableViewCell.detailTextLabel?.text = formatter.string(from: salesInvoice.issueDate as! Date)
        self.paymentDayTableViewCell.detailTextLabel?.text = formatter.string(from: salesInvoice.paymentDate as! Date)

        if !TransitionManager.transitions(for: salesInvoice).isEmpty {
            let transitButtonItem = UIBarButtonItem(title: "Change state", style: .plain, target: self, action: #selector(SalesInvoieceViewController.transitStatus) )
            navigationItem.rightBarButtonItems = [transitButtonItem]
        }
    }
    
    func transitStatus() {
        let alertController = UIAlertController(title: "Select new stauts", message: "", preferredStyle: .actionSheet)
        
        for status in TransitionManager.transitions(for: salesInvoice) {
            let changeStatusAction = UIAlertAction(title: "\(status)", style: .default, handler: {(alert: UIAlertAction!) in
                TransitionManager.transit(transferable: self.salesInvoice, to: status)
                let _ = self.navigationController?.popViewController(animated: true)
            })
            alertController.addAction(changeStatusAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        self.refreshable?.refresh()
    }
    
    
}


extension SalesInvoieceViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = Bundle.main.loadNibNamed("SalesInvoicePositionViewCell", owner: self, options: nil)?.first as! SalesInvoicePositionViewCell
            let salesInvoicePosition = salesInvoice.orderredPositions[indexPath.row]
            cell.salesInvoicePosition = salesInvoicePosition
            return cell
        } else if indexPath.section == 2 {
            let cell = Bundle.main.loadNibNamed("SalesInvoiceSummaryViewCell", owner: self, options: nil)?.first as! SalesInvoiceSummaryViewCell
            let salesInvoiceSummary = salesInvoice.orderredSummaries[indexPath.row]
            cell.salesInvoiceSummary = salesInvoiceSummary
            return cell
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 5
        case 1:
            return salesInvoice.positions?.count ?? 0
        case 2:
            return salesInvoice.summaries?.count ?? 0
        default:
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 1:
            return CGFloat(100)
        case 2:
            return CGFloat(100)
        default:
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
}

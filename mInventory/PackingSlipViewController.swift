//
//  PackingSlipViewController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 13.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class PackingSlipViewController: UITableViewController {
    
    @IBOutlet weak var numberTableViewCell: UITableViewCell!
    @IBOutlet weak var dateTableViewCell: UITableViewCell!
    @IBOutlet weak var statusTableViewCell: UITableViewCell!
    @IBOutlet weak var customerTableViewCell: UITableViewCell!
    
    var packingSlip : PackingSlip!
    var packingSlipService = PackingSlipService()
    var refreshable: RefreshableDelegate?
    
    var positions : [PackingSlipPosition]?

    override func viewDidLoad() {
        super.viewDidLoad()

        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(PackingSlipViewController.save(_:)))
        if TransitionManager.transitions(for: packingSlip).isEmpty {
            navigationItem.rightBarButtonItems = [saveBarButtonItem]
        } else {
            let transitButtonItem = UIBarButtonItem(title: "Change state", style: .plain, target: self, action: #selector(PackingSlipViewController.transitStatus) )
            let fexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            navigationItem.rightBarButtonItems = [saveBarButtonItem, fexibleSpace, transitButtonItem, fexibleSpace]
        }
        
        self.navigationController!.setToolbarHidden(false, animated: true)
        
        var items = [UIBarButtonItem]()
        
        let allPositionsButton = UIBarButtonItem(title: "All", style: UIBarButtonItemStyle.done, target: self, action: #selector(PackingSlipViewController.showAllPositions))
        let emptyPositionsButton = UIBarButtonItem(title: "Empty", style: UIBarButtonItemStyle.done, target: self, action: #selector(PackingSlipViewController.showEmptyPositions))
        let realizedPositionsButton = UIBarButtonItem(title: "Pending", style: UIBarButtonItemStyle.done, target: self, action: #selector(PackingSlipViewController.showPendingPositions))

        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(allPositionsButton)
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(emptyPositionsButton)
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(realizedPositionsButton)
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))

        self.toolbarItems = items
        self.showAllPositions()
        
        
        tableView.isUserInteractionEnabled = packingSlip.isEditable
    }
    
    func save(_ sender: UIBarButtonItem) {
        packingSlipService.save()
        let _ = navigationController?.popViewController(animated: true)
        refreshable?.refresh()
    }
    
    func showAllPositions() {
        self.positions = packingSlip.orderredArray
        tableView.reloadData()
    }
    func showEmptyPositions() {
        self.positions = packingSlip.orderredArray.filter({$0.isEmpty})
        tableView.reloadData()
    }
    func showPendingPositions() {
        self.positions = packingSlip.orderredArray.filter({!$0.isEmpty})
        tableView.reloadData()
    }
    
    func transitStatus() {
        let alertController = UIAlertController(title: "Select new stauts", message: "", preferredStyle: .actionSheet)
        
        for status in TransitionManager.transitions(for: packingSlip) {
            let changeStatusAction = UIAlertAction(title: "\(status)", style: .default, handler: {(alert: UIAlertAction!) in
                TransitionManager.transit(transferable: self.packingSlip!, to: status)
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
extension PackingSlipViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("PackingSlipPositionViewCell", owner: self, options: nil)?.first as! PackingSlipPositionViewCell
        
        if let position = positions?[indexPath.row] {
            cell.packingSlipPosition = position
        }

        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positions?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
}


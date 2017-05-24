//
//  SelectNSManagedObjectController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 09.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class SelectNSManagedObjectController: UITableViewController {

    var service : NSManagedObjectService!
    var onSelectFunction : ((_:NSManagedObject?) -> Void)!

    let searchController = UISearchController(searchResultsController: nil)
    var searchPredicate: NSPredicate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let predicate = searchPredicate {
            service.findBy(predicate: predicate)
        } else {
            service.findAll()
        }

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension SelectNSManagedObjectController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Entity", for: indexPath)
        let entity = service.object(at: indexPath)
        
        if let detailedEntity = entity as? DetailedEntity {
            cell.configure(with: detailedEntity)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entity = service.object(at: indexPath)
        let _ = navigationController?.popViewController(animated: true)
        self.onSelectFunction(entity)
    }
}

// MARK: UISearchResultsUpdating
extension SelectNSManagedObjectController: UISearchResultsUpdating {
    
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        service.findByQuery(query: searchController.searchBar.text!)
        tableView.reloadData()
    }
}



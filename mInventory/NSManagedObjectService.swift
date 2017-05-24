//
//  Service.swift
//  mInventory
//
//  Created by Łukasz Zielony on 09.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit
import CoreData

class NSManagedObjectService {
    
    fileprivate var entityName: String
    fileprivate var queryProperty: String
    fileprivate var _controller : NSFetchedResultsController<NSManagedObject>?
    
    init (entityName: String, queryProperty: String) {
        self.entityName = entityName
        self.queryProperty = queryProperty
    }
    
    func save() {
        do {
            try persistentContainer?.viewContext.save()
        } catch let error {
            print(error)
        }
    }

    func dictionary(byStringKey key: String) -> [String:NSManagedObject] {
        var result: [String:NSManagedObject] = [:]
        let service = NSManagedObjectService(entityName: entityName, queryProperty: queryProperty)
        service.findAll()
        for index in 0..<service.count() {
            let entity = service.object(at: IndexPath(row: index, section: 0))
            result[entity.value(forKey: key) as! String] = entity
        }
        
        return result
    }

    
    func findAll()  {
        performFetch(controller: controller)
    }
    
    
    func findBy(predicate: NSPredicate) {
        let controller = self.controller
        controller.fetchRequest.predicate = predicate
        performFetch(controller: controller)
    }
    func findBy(predicates: [NSPredicate]) {
        let controller = self.controller
        
        if !predicates.isEmpty {
            let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            controller.fetchRequest.predicate = predicate
        }
        
        performFetch(controller: controller)
    }

    func findByQuery(query: String) {
        let controller = self.controller
        
        if !query.isEmpty {
            controller.fetchRequest.predicate =  NSPredicate(format: "\(queryProperty) contains[c] %@", query)
        }
        
        performFetch(controller: controller)
    }

    func count() -> Int {
        var result = 0
        do {
            result = try persistentContainer!.viewContext.count(for: _controller!.fetchRequest)
        } catch let error as NSError {
            print (error)
        }
        return result
    }
    
    func object(at: IndexPath) -> NSManagedObject {
        return _controller!.object(at: at)
    }

    func countAll() -> Int {
        var result = 0
        let fetchRequest = self.fetchRequest
        do {
            result = try persistentContainer!.viewContext.count(for: fetchRequest)
        } catch let error as NSError {
            print (error)
        }
        return result
    }
}


extension NSManagedObjectService {
    
    fileprivate func performFetch(controller: NSFetchedResultsController<NSManagedObject>) {
        do {
            try controller.performFetch()
            _controller = controller
        } catch let error as NSError{
            print("\(error) -> \(error.userInfo)")
        }
    }
    
    
    var fetchRequest: NSFetchRequest<NSManagedObject> {
        let fr = NSFetchRequest<NSManagedObject>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: queryProperty, ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        fr.sortDescriptors = [sortDescriptor]
        
        return fr
    }

    var controller: NSFetchedResultsController<NSManagedObject> {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        let sortDescriptor = NSSortDescriptor(key: queryProperty, ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer!.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return controller
    }

    fileprivate var appDelegate: AppDelegate? {
        get {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return nil
            }
            
            return appDelegate
        }
    }
    
     var persistentContainer: NSPersistentContainer? {
        return appDelegate?.persistentContainer
    }

}

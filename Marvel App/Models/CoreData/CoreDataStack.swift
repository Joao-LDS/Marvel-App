//
//  CoreDataStack.swift
//  Marvel App
//
//  Created by João Luis Santos on 07/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
        
    var persistentContainer: NSPersistentContainer {
        let container = NSPersistentContainer(name: "Marvel_App")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("DEBUG: CoreData Error - \(error.localizedDescription)")
            }
        }
        return container
    }
    
    var getFetchResultController: NSFetchedResultsController<HeroObject>? {
        return NSFetchedResultsController(fetchRequest: getFetchResult, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    var getFetchResult: NSFetchRequest<HeroObject> {
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let request: NSFetchRequest<HeroObject> = HeroObject.fetchRequest()
        request.sortDescriptors = [sort]
        request.predicate = nil
        return request
    }
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    var entity: NSEntityDescription {
        let entity = NSEntityDescription.entity(forEntityName: "HeroObject", in: context)
        return entity!
    }
    
    func save() throws {
        do {
            try context.save()
        } catch {
            print("DEBUG: CoreData Error - \(error.localizedDescription)")
        }
    }
    
    func delete(hero name: String) -> Bool {
        let predicate = NSPredicate(format: "name == %@", name)
        let request = getFetchResult
        request.predicate = predicate
        
        if let heros = try? context.fetch(request) {
            for hero in heros {
                context.delete(hero)
            }
        }
        do {
            try save()
            return true
        } catch {
            return false
        }
    }
    
    func fetchObjectHero() -> [HeroObject]? {
        let fetchedResultController = getFetchResultController

        do {
            try fetchedResultController?.performFetch()
            return fetchedResultController?.fetchedObjects
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func heroDidSaved(_ name: String) -> Bool {
        let predicate = NSPredicate(format: "name == %@", name)
        let fetchedResultController = getFetchResultController
        fetchedResultController?.fetchRequest.predicate = predicate
        
        do {
            try fetchedResultController?.performFetch()
            if fetchedResultController?.fetchedObjects?.count != 0 {
                return true
            } else {
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
}

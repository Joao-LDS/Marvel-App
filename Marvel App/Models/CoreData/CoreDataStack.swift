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
        
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Marvel_App")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("DEBUG: CoreData Error - \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    var entity: NSEntityDescription {
        let entity = NSEntityDescription.entity(forEntityName: "HeroObject", in: context)
        return entity!
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("DEBUG: CoreData Error - \(error.localizedDescription)")
        }
    }
    
    func fetchObjectHero() -> [HeroObject]? {
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let request: NSFetchRequest<HeroObject> = HeroObject.fetchRequest()
        request.sortDescriptors = [sort]
        let fetchedResultControllerHeroObject: NSFetchedResultsController<HeroObject>? = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try fetchedResultControllerHeroObject?.performFetch()
            return fetchedResultControllerHeroObject?.fetchedObjects
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func heroDidSaved(_ name: String) -> Bool {
        let predicate = NSPredicate(format: "name == %@", name)
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let request: NSFetchRequest<HeroObject> = HeroObject.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = [sort]
        let fetchedResult: NSFetchedResultsController<HeroObject>? = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        
        
        do {
            try fetchedResult?.performFetch()
            if fetchedResult?.fetchedObjects?.count != 0 {
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

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
        persistentContainer.viewContext
    }
    
    var entity: NSEntityDescription {
        let entity = NSEntityDescription.entity(forEntityName: "HeroObject", in: context)
        return entity!
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    lazy var fetchedResultController: NSFetchedResultsController<HeroObject>? = {
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let request: NSFetchRequest<HeroObject> = HeroObject.fetchRequest()
        request.sortDescriptors = [sort]
        request.predicate = nil
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    func fetchObjectHero() -> [HeroObject]? {
        let fetchedResultControllerHeroObject = fetchedResultController

        do {
            try fetchedResultControllerHeroObject?.performFetch()
            return fetchedResultControllerHeroObject?.fetchedObjects
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    func heroDidSaved(_ name: String) -> Bool {
        let predicate = NSPredicate(format: "name == %@", name)
        let fetchedResultController = fetchedResultController
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
    
    func delete(hero: String) -> Bool {
        let predicate = NSPredicate(format: "name == %@", hero)
        let fetchedResultController = fetchedResultController
        fetchedResultController?.fetchRequest.predicate = predicate
        
        if let hero = fetchedResultController?.fetchedObjects?.first {
            context.delete(hero)
            return true
        } else {
            return false
        }
    }
    
}

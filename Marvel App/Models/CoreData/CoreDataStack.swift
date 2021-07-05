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
    
    var fetchedResultController: NSFetchedResultsController<HeroObject>? {
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let request: NSFetchRequest<HeroObject> = HeroObject.fetchRequest()
        request.sortDescriptors = [sort]
        request.predicate = nil
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func fetchObjectHero(_ argument: String? = nil) -> [HeroObject]? {
        let fetchedResultController = fetchedResultController
        if let argument = argument {
            let predicate = NSPredicate(format: "name == %@", argument)
            fetchedResultController?.fetchRequest.predicate = predicate
        }
        
        do {
            try fetchedResultController?.performFetch()
            return fetchedResultController?.fetchedObjects
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    func heroDidSaved(_ name: String) -> Bool {
        guard let objects = fetchObjectHero(name) else { return false }
        return objects.count > 0 ? true :  false
    }
    
    func delete(hero: String) -> Bool {
        guard let hero = fetchObjectHero(hero)?.first else { return false }
        context.delete(hero)
        save()
        return true
    }
    
}

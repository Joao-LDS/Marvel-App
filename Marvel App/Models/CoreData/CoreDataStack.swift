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
    var fetchedResultControllerHeroObject: NSFetchedResultsController<HeroObject>?
        
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
            let heros = fetchObjectHero()
            for hero in heros! {
                print(hero.name)
                for url in hero.urls!.allObjects as! [UrlsObject] {
                    print(url.url)
                    print(url.type)
                }
            }
        } catch {
            print("DEBUG: CoreData Error - \(error.localizedDescription)")
        }
    }
    
    func fetchObjectHero() -> [HeroObject]? {
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let request: NSFetchRequest<HeroObject> = HeroObject.fetchRequest()
        request.sortDescriptors = [sort]
        fetchedResultControllerHeroObject = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try fetchedResultControllerHeroObject?.performFetch()
            return fetchedResultControllerHeroObject?.fetchedObjects
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
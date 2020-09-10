//
//  PersistenceService.swift
//  Marvel App
//
//  Created by João Luis Santos on 10/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService {
    
    static let shared = PersistenceService()
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Marvel_App")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}

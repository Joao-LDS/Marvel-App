//
//  MarvelData+CoreDataProperties.swift
//  Marvel App
//
//  Created by João Luis Santos on 01/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//
//

import Foundation
import CoreData


extension MarvelData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MarvelData> {
        return NSFetchRequest<MarvelData>(entityName: "MarvelData")
    }

    @NSManaged public var count: Int16
    @NSManaged public var limit: Int16
    @NSManaged public var offset: Int16
    @NSManaged public var results: NSObject?
    @NSManaged public var total: Int16
    @NSManaged public var heroes: NSSet?

}

// MARK: Generated accessors for heroes
extension MarvelData {

    @objc(addHeroesObject:)
    @NSManaged public func addToHeroes(_ value: Hero)

    @objc(removeHeroesObject:)
    @NSManaged public func removeFromHeroes(_ value: Hero)

    @objc(addHeroes:)
    @NSManaged public func addToHeroes(_ values: NSSet)

    @objc(removeHeroes:)
    @NSManaged public func removeFromHeroes(_ values: NSSet)

}

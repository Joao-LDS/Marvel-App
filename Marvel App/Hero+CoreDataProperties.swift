//
//  Hero+CoreDataProperties.swift
//  Marvel App
//
//  Created by João Luis Santos on 01/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//
//

import Foundation
import CoreData


extension Hero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hero> {
        return NSFetchRequest<Hero>(entityName: "Hero")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var thumbnail: NSObject?
    @NSManaged public var urls: NSObject?
    @NSManaged public var thumb: HeroThumbnail?
    @NSManaged public var url: NSSet?

}

// MARK: Generated accessors for url
extension Hero {

    @objc(addUrlObject:)
    @NSManaged public func addToUrl(_ value: MarvelURL)

    @objc(removeUrlObject:)
    @NSManaged public func removeFromUrl(_ value: MarvelURL)

    @objc(addUrl:)
    @NSManaged public func addToUrl(_ values: NSSet)

    @objc(removeUrl:)
    @NSManaged public func removeFromUrl(_ values: NSSet)

}

//
//  HeroThumbnail+CoreDataProperties.swift
//  Marvel App
//
//  Created by João Luis Santos on 01/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//
//

import Foundation
import CoreData


extension HeroThumbnail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeroThumbnail> {
        return NSFetchRequest<HeroThumbnail>(entityName: "HeroThumbnail")
    }

    @NSManaged public var ext: String?
    @NSManaged public var path: String?

}

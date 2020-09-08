//
//  MarvelURL+CoreDataProperties.swift
//  Marvel App
//
//  Created by João Luis Santos on 01/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//
//

import Foundation
import CoreData


extension MarvelURL {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MarvelURL> {
        return NSFetchRequest<MarvelURL>(entityName: "MarvelURL")
    }

    @NSManaged public var type: String?
    @NSManaged public var url: String?

}

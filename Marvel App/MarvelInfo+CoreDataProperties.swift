//
//  MarvelInfo+CoreDataProperties.swift
//  Marvel App
//
//  Created by João Luis Santos on 01/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//
//

import Foundation
import CoreData


extension MarvelInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MarvelInfo> {
        return NSFetchRequest<MarvelInfo>(entityName: "MarvelInfo")
    }

    @NSManaged public var code: Int16
    @NSManaged public var data: NSObject?
    @NSManaged public var status: String?
    @NSManaged public var marveldata: MarvelData?

}

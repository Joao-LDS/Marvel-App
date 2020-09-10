//
//  ViewController+CoreData.swift
//  Marvel App
//
//  Created by João Luis Santos on 08/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {

    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

}

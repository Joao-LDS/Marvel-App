//
//  DetailHeroViewModel.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DetailHeroViewModel: NSObject {
    
    var hero: Hero?
    var marvelURL: [MarvelURL]? {
        get {
            guard let urls = self.hero?.urls else { return nil }
            return urls as! [MarvelURL]
        }
    }
    
    func getUrlFromMarvelURL(index: Int) -> URL? {
        guard let marvelURL = marvelURL else { return nil }
        let url = URL(string: marvelURL[index].url!)
        return url
    }
    
    func getTypeOfMarvelURL() -> [String] {
        var array: [String] = []
        guard let marvelURL = marvelURL else { return [] }
        for marvelURL in marvelURL {
            array.append(marvelURL.type!)
        }
        return array
    }
    
    func saveHero(_ context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Hero", in: context)!
        let _ = NSManagedObject(entity: entity, insertInto: context)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

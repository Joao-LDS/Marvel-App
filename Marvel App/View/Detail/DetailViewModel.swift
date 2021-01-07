//
//  DetailViewModel.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation
import CoreData

class DetailViewModel {
    
    let coreDataStack = CoreDataStack.shared
    var hero: Hero!
    var urls: [Urls]? {
        return self.hero.urls
    }
    
    init(hero: Hero) {
        self.hero = hero
    }
    
    func saveHero(image: Data) {
        let heroObject = HeroObject(entity: coreDataStack.entity, insertInto: coreDataStack.context)
        heroObject.name = hero.name
        heroObject.desc = hero.desc
        heroObject.image = image
        guard let urls = urls else { return }
        var urlsObjectArray: [UrlsObject] = []
        for url in urls {
            let urlObject = UrlsObject(context: coreDataStack.context)
            urlObject.type = url.type
            urlObject.url = url.url
            urlsObjectArray.append(urlObject)
        }
        heroObject.urls = NSSet(array: urlsObjectArray)
        
        coreDataStack.save()
    }
    
    func getUrlFromMarvelURL(index: Int) -> URL? {
        guard let urls = urls else { return nil }
        let url = URL(string: urls[index].url!)
        return url
    }
    
    func getTitlesURL() -> [String] {
        var titles: [String] = []
        guard let urls = urls else { return [] }
        for url in urls {
            titles.append(url.type!)
        }
        return titles
    }
    
}

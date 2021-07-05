//
//  FavoriteListViewModel.swift
//  Marvel App
//
//  Created by João Luis Santos on 08/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation
import CoreData

protocol FavoriteListViewModelProtocol {
    var herosObject: [HeroObject]? { get set }
    func convertHeroObjectToHero(index: Int) -> Hero
    func fetchHerosObject()
}

class FavoriteListViewModel: FavoriteListViewModelProtocol {
    
    // MARK: =============== Properties ===============
    
    var herosObject: [HeroObject]?
    private let coreDataStack = CoreDataStack.shared
    
    // MARK: =============== Methods ===============
    
    func fetchHerosObject() {
        herosObject = coreDataStack.fetchObjectHero()
    }
    
    func convertHeroObjectToHero(index: Int) -> Hero {
        let heroObject = herosObject![index]
        var hero = Hero()
        hero.name = heroObject.name
        hero.desc = heroObject.desc
        hero.image = heroObject.image
        let urls = heroObject.urls!
        var urlsArray: [Urls] = []
        for url in urls.allObjects as! [UrlsObject] {
            let urlsHero = Urls(type: url.type, url: url.url)
            urlsArray.append(urlsHero)
        }
        hero.urls = urlsArray
        return hero
    }
}

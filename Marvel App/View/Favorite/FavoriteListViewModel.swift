//
//  FavoriteListViewModel.swift
//  Marvel App
//
//  Created by João Luis Santos on 08/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation
import CoreData

class FavoriteListViewModel {
    
    let herosObject: [HeroObject]?
    
    init(herosObject: [HeroObject]?) {
        self.herosObject = herosObject
    }
    
    func convertHeroObjectToHero() {
        
    }
}

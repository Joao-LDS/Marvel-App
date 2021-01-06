//
//  DetailViewModel.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetailViewModel: NSObject {
    
    var hero: Hero!
    var urls: [Urls]? {
        return self.hero.urls
    }
    
    init(hero: Hero) {
        self.hero = hero
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

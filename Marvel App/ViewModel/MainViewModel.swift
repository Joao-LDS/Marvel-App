//
//  MainViewModel.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate {
    func reloadCollection()
}

class MainViewModel {
    
    var heroes: [HeroData] = []
    var delegate: MainViewModelDelegate?
    lazy var service = MarvelAPI()
    var currentPage = 0
    var total = 0 // Armazena o total de heróis que a API retorna, serva para saber se precisamos pedir mais ou não.
    var nameHero = ""
    
    func fetchHeroes(newRequest: Bool) {
        service.request(name: nameHero, page: currentPage) { response in
            if let response = response, let results = response.data?.results, let total = response.data?.total {
                if newRequest {
                    self.heroes = results
                } else {
                    self.heroes += results
                }
                self.total = total
                self.delegate?.reloadCollection()
            }
        }
    }
    
    func fetchMoreHeroes(afterTo index: Int) {
        if index == heroes.count - 10 {
            currentPage += 1
            fetchHeroes(newRequest: false)
        }
    }
    
}

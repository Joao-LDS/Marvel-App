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
    
    var heroes: [Hero] = []
    var delegate: MainViewModelDelegate?
    lazy var service = MarvelAPI()
    var currentPage = 0
    var totalHeroesReturnedAPI = 0 // Armazena o total de heróis que a API retorna, serva para saber se precisamos pedir mais ou não.
    
    func fetchHeroes(heroName: String?, newRequest: Bool) {
        service.request(name: heroName, page: currentPage) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(JSON.self, from: data)
                    if let heroes = json.data?.results, let total = json.data?.total {
                        if newRequest {
                            self.heroes = heroes
                        } else {
                            self.heroes += heroes
                        }
                        self.totalHeroesReturnedAPI = total
                        self.delegate?.reloadCollection()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchMoreHeroes(afterTo index: Int) {
        if index == heroes.count - 10 {
            currentPage += 1
            fetchHeroes(heroName: nil, newRequest: false)
        }
    }
    
}

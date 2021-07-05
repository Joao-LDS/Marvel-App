//
//  MainViewModel.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation

protocol MainViewModelProtocol {
    var successRequest: (() -> Void)? { get set }
    var failureRequest: ((String) -> Void)? { get set }
    var heroes: [Hero] { get set }
    func fetchHeroes(heroName: String?, newRequest: Bool)
    func fetchMoreHeroes(afterTo index: Int)
}

class MainViewModel: MainViewModelProtocol{
    
    // MARK: =============== Properties ===============
    
    var successRequest: (() -> Void)?
    var failureRequest: ((String) -> Void)?
    let coreDataStack = CoreDataStack.shared
    var heroes: [Hero] = []
    private var repository: MarvelRepository
    private var currentPage = 0
    private var totalHeroesReturnedAPI = 0 // Armazena o total de heróis que a API retorna, serva para saber se precisamos pedir mais.
    
    // MARK: =============== Init ===============
    
    init(repository: MarvelRepository = MarvelRepository()) {
        self.repository = repository
    }
    
    // MARK: =============== Methods ===============
    
    func fetchHeroes(heroName: String?, newRequest: Bool) {
        repository.request(name: heroName, page: currentPage) { result in
            switch result {
            case .success(let jsonObject):
                if let heroes = jsonObject.data?.results, let total = jsonObject.data?.total {
                    if newRequest {
                        self.heroes = heroes
                    } else {
                        self.heroes += heroes
                    }
                    self.totalHeroesReturnedAPI = total
                    self.successRequest?()
                }
            case .failure(let error):
                self.failureRequest?(error.message)
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

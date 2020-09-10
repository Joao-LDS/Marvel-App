//
//  FavoriteListViewController.swift
//  Marvel App
//
//  Created by João Luis Santos on 08/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    let viewModel = FavoriteListViewModel()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(HeroCustomCell.self, forCellWithReuseIdentifier: "cell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.fetch(self.context)
        setupView()
    }

}

//extension FavoriteListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.fetchResult.fetchedObjects?.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HeroCustomCell
//        let obj = viewModel.fetchResult.fetchedObjects
//        let hero = obj![indexPath.row]
//        cell.configureCell(hero: hero)
//        return cell
//    }
    
    
//}

extension FavoriteListViewController: ConfigureView {
    func addView() {
        
    }
    
    func addConstraints() {
        
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .red
    }
    
}

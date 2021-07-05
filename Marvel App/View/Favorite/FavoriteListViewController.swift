//
//  FavoriteListViewController.swift
//  Marvel App
//
//  Created by João Luis Santos on 08/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    // MARK: =============== Properties ===============
    
    let viewModel: FavoriteListViewModelProtocol
    var uiview: FavoriteListView
    
    // MARK: =============== Init ===============
    
    init(viewModel: FavoriteListViewModelProtocol) {
        self.viewModel = viewModel
        uiview = FavoriteListView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: =============== View Lifecicle ===============
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchHerosObject()
        uiview.collection.reloadData()
    }
    
    override func loadView() {
        self.view = uiview
    }
    
    // MARK: =============== Methods ===============
    
    func configureView() {
        uiview.closeButton.addTarget(self, action: #selector(self.closeButtonPressed), for: .touchUpInside)
    }
    
    func setupCollectionView() {
        uiview.collection.delegate = self
        uiview.collection.dataSource = self
        uiview.collection.register(HeroCustomCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    // MARK: =============== Selectors ===============
    
    @objc func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: =============== UICollectionViewDelegateFlowLayout, UICollectionViewDataSource ===============

extension FavoriteListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.65)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.herosObject?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HeroCustomCell
        let hero = viewModel.convertHeroObjectToHero(index: indexPath.row)
        cell.configureCell(hero)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = viewModel.convertHeroObjectToHero(index: indexPath.row)
        let viewModel = DetailViewModel(hero: hero)
        let controller = DetailViewController(viewModel: viewModel, showFromFavoriteList: true)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    
}

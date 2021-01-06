//
//  MainViewController.swift
//  Marvel App
//
//  Created by João Luis Santos on 04/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties

    let viewModel: MainViewModel
    var uiview: MainView
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        uiview = MainView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
//        searchBar.delegate = self
        addToolbarKeyboard()
        configureView()
    }
    
    override func loadView() {
        self.view = uiview
    }
    
    // MARK: - Methods
    
    func configureView() {
        uiview.searchButton.addTarget(self, action: #selector(self.searchButtonPressed), for: .touchUpInside)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        uiview.collection.delegate = self
        uiview.collection.dataSource = self
        uiview.collection.register(HeroCustomCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func addToolbarKeyboard() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([flexible, cancel], animated: true)
//        searchBar.inputAccessoryView = toolbar
    }
    
    // MARK: - Selectors
    
    @objc func searchButtonPressed() {
        guard let heroName = uiview.searchTextField.text else { return }
        viewModel.fetchHeroes(heroName: heroName, newRequest: true)
    }
    
//    @objc func handleSearch() {
////        searchBar.resignFirstResponder()
//        guard let name = uiview.searchTextField.text else { return }
//        viewModel.currentPage = 0
//        viewModel.fetchHeroes(newRequest: true)
//        uiview.collection.setContentOffset(.zero, animated: true) // scroll collection to top
//    }

    @objc func dismissKeyboard() {
//        searchBar.resignFirstResponder()
    }
    
    @objc func favoriteButtonTapped() {
        let vc = FavoriteListViewController()
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - MainViewModelDelegate

extension MainViewController: MainViewModelDelegate {
    func reloadCollection() {
        uiview.collection.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    // Active button search by keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        handleSearch()
//        searchBar.resignFirstResponder()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HeroCustomCell
        let hero = viewModel.heroes[indexPath.row]
        cell.configureCell(hero)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = viewModel.heroes[indexPath.row]
        let viewModel = DetailViewModel(hero: hero)
        let vc = DetailViewController(viewModel: viewModel)
//        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.fetchMoreHeroes(afterTo: indexPath.row)
    }
    
}

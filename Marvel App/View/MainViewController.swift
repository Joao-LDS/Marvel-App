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

    private let viewModel = MainViewModel()
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.tintColor = .white
//        bar.searchTextField.textColor = .white
        return bar
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(HeroCustomCell.self, forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    // MARK: - View Lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        viewModel.delegate = self
        searchBar.delegate = self
        addToolbarKeyboard()
        setupView()
    }
    
    // MARK: - Methods
    
    func addToolbarKeyboard() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([flexible, cancel], animated: true)
        searchBar.inputAccessoryView = toolbar
    }
    
    // MARK: - Selectors
    
    @objc func handleSearch() {
        searchBar.resignFirstResponder()
        guard let name = searchBar.text else { return }
        viewModel.nameHero = name
        viewModel.currentPage = 0
        viewModel.fetchHeroes(newRequest: true)
        collection.setContentOffset(.zero, animated: true) // scroll collection to top
    }

    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}

// MARK: - MainViewModelDelegate

extension MainViewController: MainViewModelDelegate {
    func reloadCollection() {
        self.collection.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    // Active button search by keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        handleSearch()
        searchBar.resignFirstResponder()
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
        cell.configureCell(hero: hero)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailHeroViewController(viewModel.heroes[indexPath.row])
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.fetchMoreHeroes(afterTo: indexPath.row)
    }
    
}

// MARK: - ConfigureView

extension MainViewController: ConfigureView {
    func addView() {
        view.addSubview(collection)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .red
        navigationItem.title = "MARVEL APP"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
                                                                            .font: UIFont(name: "Marvel-Regular", size: 50)!]
        } else {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                                       .font: UIFont(name: "Marvel-Regular", size: 28)!]
        }
        navigationItem.titleView = searchBar // Add search bar in navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch))
        navigationItem.rightBarButtonItem?.tintColor = .white // Change color button
        
        // Background color navigationController and off translucent
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.barStyle = .blackTranslucent
    }
}

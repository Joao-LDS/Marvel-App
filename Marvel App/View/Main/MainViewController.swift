//
//  MainViewController.swift
//  Marvel App
//
//  Created by João Luis Santos on 04/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: =============== Properties ===============

    private var viewModel: MainViewModelProtocol
    private var uiview: MainView
    
    // MARK: =============== Init ===============
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        uiview = MainView()
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
        addGestureToDismissKeyboard()
        bind()
    }
    
    override func loadView() {
        self.view = uiview
    }
    
    // MARK: =============== Methods ===============
    
    func configureView() {
        uiview.searchButton.addTarget(self, action: #selector(self.searchButtonPressed), for: .touchUpInside)
        uiview.favoriteButton.addTarget(self, action: #selector(self.favoriteButtonPressed), for: .touchUpInside)
        
        uiview.searchTextField.delegate = self
        
        uiview.label.text = "BUSQUE UM PERSONAGEM"
    }
    
    func setupCollectionView() {
        uiview.collection.delegate = self
        uiview.collection.dataSource = self
        uiview.collection.register(HeroCustomCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func addGestureToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        uiview.collection.addGestureRecognizer(tap)
    }
    
    func bind() {
        viewModel.successRequest = { [unowned self] in
            self.uiview.activityIndicator.stopAnimating()
            self.uiview.collection.reloadData()
        }
        
        viewModel.failureRequest = { [unowned self] message in
            self.uiview.activityIndicator.stopAnimating()
            self.uiview.label.isHidden = false
            self.uiview.label.text = message.uppercased()
        }
    }
    
    // MARK: =============== Selectors ===============
    
    @objc func searchButtonPressed() {
        self.uiview.label.isHidden = true
        self.uiview.activityIndicator.startAnimating()
        guard let heroName = uiview.searchTextField.text else { return }
        viewModel.fetchHeroes(heroName: heroName, newRequest: true)
        dismissKeyboard()
    }
    
    @objc func favoriteButtonPressed() {
        let heros = viewModel.fetchHerosObjectFromCoraData()
        let viewModel = FavoriteListViewModel(herosObject: heros)
        let controller = FavoriteListViewController(viewModel: viewModel)
        present(controller, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: =============== MainViewModelDelegate ===============

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        searchButtonPressed()
        return true
    }
}

// MARK: =============== UICollectionViewDelegateFlowLayout, UICollectionViewDataSource ===============

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.65)
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
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.fetchMoreHeroes(afterTo: indexPath.row)
    }
    
}

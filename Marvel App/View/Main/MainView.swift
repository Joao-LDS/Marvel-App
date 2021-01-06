//
//  MainView.swift
//  Marvel App
//
//  Created by João Luis Santos on 04/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import UIKit

class MainView: UIView {

    // MARK: - Properties
    
    lazy var searchButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var imageFavoriteButton: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension MainView: ConfigureView {
    func addView() {
        addSubview(searchButton)
        addSubview(searchTextField)
        addSubview(collection)
        addSubview(imageFavoriteButton)
        addSubview(favoriteButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
            searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 16),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -16),
            searchTextField.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            collection.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            favoriteButton.widthAnchor.constraint(equalToConstant: 55),
            favoriteButton.heightAnchor.constraint(equalToConstant: 55),
            
            imageFavoriteButton.widthAnchor.constraint(equalToConstant: 25),
            imageFavoriteButton.heightAnchor.constraint(equalToConstant: 25),
            imageFavoriteButton.centerYAnchor.constraint(equalTo: favoriteButton.centerYAnchor),
            imageFavoriteButton.centerXAnchor.constraint(equalTo: favoriteButton.centerXAnchor)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .red
        
        searchButton.setTitle("Buscar", for: .normal)
        
        searchTextField.backgroundColor = .white
        searchTextField.layer.cornerRadius = 20
        
        collection.backgroundColor = .clear
        
        imageFavoriteButton.image = #imageLiteral(resourceName: "add-to-favorites")
        
        favoriteButton.backgroundColor = .red
        favoriteButton.layer.cornerRadius = 28
        favoriteButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        favoriteButton.layer.shadowOffset = .zero
        favoriteButton.layer.shadowRadius = 8
        favoriteButton.layer.shadowOpacity = 0.5
    }
}

//
//  MainView.swift
//  Marvel App
//
//  Created by João Luis Santos on 04/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import UIKit

class MainView: UIView {

    // MARK: =============== Properties ===============
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView()
        ac.translatesAutoresizingMaskIntoConstraints = false
        return ac
    }()
    
    lazy var searchButton: FloatButton = {
        let view = FloatButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var favoriteButton: FloatButton = {
        let button = FloatButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: =============== Init ===============
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: =============== ConfigureView ===============

extension MainView: ConfigureView {
    func addView() {
        addSubview(searchButton)
        addSubview(searchTextField)
        addSubview(collection)
        addSubview(favoriteButton)
        addSubview(label)
        addSubview(activityIndicator)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -16),
            searchTextField.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collection.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .red
        
        searchButton.imageview.image = #imageLiteral(resourceName: "search")
        
        activityIndicator.style = .whiteLarge
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Marvel-Regular", size: 24)
        label.textColor = .white
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always
        searchTextField.textColor = .red
        searchTextField.font = UIFont(name: "Marvel-Regular", size: 24)
        searchTextField.autocapitalizationType = .allCharacters
        searchTextField.backgroundColor = .white
        searchTextField.layer.cornerRadius = 20
        
        collection.backgroundColor = .clear
        
        favoriteButton.imageview.image = #imageLiteral(resourceName: "favorite")
        
    }
}

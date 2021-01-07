//
//  FavoriteListView.swift
//  Marvel App
//
//  Created by João Luis Santos on 07/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import UIKit

class FavoriteListView: UIView {

    lazy var closeButton: FloatButton = {
        let button = FloatButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoriteListView: ConfigureView {
    func addView() {
        addSubview(collection)
        addSubview(closeButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .red
        
        closeButton.imageview.image = #imageLiteral(resourceName: "arrowLeft")
        
        collection.backgroundColor = .clear
    }
    
}

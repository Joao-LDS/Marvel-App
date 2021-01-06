//
//  FavoriteListViewController.swift
//  Marvel App
//
//  Created by João Luis Santos on 08/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var imageButton: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "close-icon-left")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}

//extension FavoriteListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.75)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
    
    
//}

extension FavoriteListViewController: ConfigureView {
    func addView() {
        view.addSubview(collection)
        closeButton.addSubview(imageButton)
        view.addSubview(closeButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 18),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            closeButton.widthAnchor.constraint(equalToConstant: 45),
            closeButton.heightAnchor.constraint(equalToConstant: 45),
            
            imageButton.widthAnchor.constraint(equalToConstant: 25),
            imageButton.heightAnchor.constraint(equalToConstant: 25),
            imageButton.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor),
            imageButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor)
        ])
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .red
    }
    
}

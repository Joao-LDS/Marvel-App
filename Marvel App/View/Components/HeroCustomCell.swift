//
//  HeroCustomCell.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import Kingfisher

class HeroCustomCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var namelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configureCell(_ hero: Hero) {
        namelabel.text = hero.name!.uppercased()
        if let data = hero.image, let image = UIImage(data: data) {
            imageView.image = image
        } else if let thumbnail = hero.thumbnail?.url {
            let url = URL(string: thumbnail)
            imageView.kf.setImage(with: url)
            imageView.kf.indicatorType = .activity
        }
    }
    
}

// MARK: - ConfigureView

extension HeroCustomCell: ConfigureView {
    func addView() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        addSubview(namelabel)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            namelabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            namelabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            namelabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28)
        ])
    }
    
    func additionalConfiguration() {
        
//        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        
        namelabel.font = UIFont(name: "Marvel-Regular", size: 38)
        namelabel.textColor = .white
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 25
        
    }
}

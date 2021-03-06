//
//  DetailView.swift
//  Marvel App
//
//  Created by João Luis Santos on 06/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    // MARK: =============== Properties ===============

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var closeButton: FloatButton = {
        let button = FloatButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var urlButtons: [UrlButton] = []
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var functionButton: FloatButton = {
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
    
    // MARK: =============== Methods ===============
    
    func createButtonsToUrls(with titles: [String]) {
        for title in titles {
            let button: UrlButton = {
                let button = UrlButton()
                button.setTitle(title.uppercased(), for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
                return button
            }()
            self.urlButtons.append(button)
        }
        addUrlButtonsInStackView()
    }
    
    func addUrlButtonsInStackView() {
        for button in urlButtons {
            stackView.addArrangedSubview(button)
        }
    }
    
}

// MARK: =============== ConfigureView ===============

extension DetailView: ConfigureView {
    func addView() {
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(functionButton)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(stackView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            functionButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 18),
            functionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 18),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -24),
                                                
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -24),
                                                  
            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24), // verify for this
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .red
        
        closeButton.imageview.image = #imageLiteral(resourceName: "arrowLeft")
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        nameLabel.font = UIFont(name: "Marvel-Regular", size: 38)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        
        descriptionLabel.font = UIFont(name: "Marvel-Regular", size: 22)
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        functionButton.imageview.image = #imageLiteral(resourceName: "favorite")
    }
    
}

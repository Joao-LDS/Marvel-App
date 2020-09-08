//
//  DetailHeroViewController.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import Kingfisher

class DetailHeroViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = DetailHeroViewModel()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        if let thumbnail = viewModel.hero?.thumbnail {
            view.kf.setImage(with: URL(string: thumbnail.url))
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        if let name = viewModel.hero?.name {
            view.text = name.uppercased()
        }
        view.font = UIFont(name: "Marvel-Regular", size: 38)
        view.textColor = .white
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var detailLabel: UILabel = {
        let view = UILabel()
        if let detail = viewModel.hero?.desc {
            view.text = detail.uppercased()
        }
        view.font = UIFont(name: "Marvel-Regular", size: 22)
        view.textAlignment = .justified
        view.numberOfLines = 0
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageCloseButton: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "close-icon-left")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add-to-favorites"), for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    init(_ hero: HeroData) {
        viewModel.hero = hero
        print(hero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureInfoButtons()
    }
    
    // MARK: - Methods
    
    func configureInfoButtons() {
        let array = viewModel.getTypeOfMarvelURL()
        for type in array {
            let infoButton: UIButton = {
                let button = CustomButton(title: type)
                button.addTarget(self, action: #selector(infosButtonTapped), for: .touchUpInside)
                return button
            }()
            self.stackView.addArrangedSubview(infoButton)
        }
    }
    
    // MARK: - Selectors
    
    @objc func infosButtonTapped(_ sender: UIButton) {
        guard let index = stackView.arrangedSubviews.firstIndex(of: sender) else { return }
        guard let url = viewModel.getUrlFromMarvelURL(index: index) else { return }
        let request = URLRequest(url: url)
        let webView = WebViewViewController(request)
        present(webView, animated: true, completion: nil)
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func favoriteButtonTapped() {
        print("\(viewModel.hero)")
    }
}

// MARK: - ConfigureView

extension DetailHeroViewController: ConfigureView {
    func addView() {
        view.addSubview(scrollView)
        closeButton.addSubview(imageCloseButton)
        scrollView.addSubview(imageView)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(favoriteButton)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(detailLabel)
        scrollView.addSubview(stackView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 18),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            favoriteButton.widthAnchor.constraint(equalToConstant: 45),
            favoriteButton.heightAnchor.constraint(equalToConstant: 45),
            
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 18),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            closeButton.widthAnchor.constraint(equalToConstant: 45),
            closeButton.heightAnchor.constraint(equalToConstant: 45),
            
            imageCloseButton.widthAnchor.constraint(equalToConstant: 25),
            imageCloseButton.heightAnchor.constraint(equalToConstant: 25),
            imageCloseButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            imageCloseButton.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.40),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -24),
                                                
            detailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            detailLabel.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 24),
            detailLabel.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -24),
                                                  
            stackView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24), // verify for this
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50)
        ])
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .red
    }
    
}

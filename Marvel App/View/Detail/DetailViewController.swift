//
//  DetailViewController.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DetailViewModelProtocol
    var uiview: DetailView
    
    
    // MARK: - Init
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        uiview = DetailView()
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func loadView() {
        self.view = uiview
    }
    
    // MARK: - Methods
    
    func configureView() {
        uiview.closeButton.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
        
        uiview.favoriteButton.addTarget(self, action: #selector(self.favoriteButtonTapped), for: .touchUpInside)
        
        let hero = viewModel.hero
        
        if let data = hero.image, let image = UIImage(data: data) {
            uiview.imageView.image = image
        } else if let thumbnail = hero.thumbnail?.url {
            let url = URL(string: thumbnail)
            uiview.imageView.kf.setImage(with: url)
            uiview.imageView.kf.indicatorType = .activity
        }
        
        let name = hero.name
        uiview.nameLabel.text = name?.uppercased()
        
        let description = hero.desc
        uiview.descriptionLabel.text = description?.uppercased()
        
        let types = viewModel.getTitlesURL()
        uiview.createButtonsToUrls(with: types)
        
        for button in uiview.urlButtons {
            button.addTarget(self, action: #selector(self.urlButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    func bind() {
        self.viewModel.showAlert = { [unowned self] message in
            let alert = CustomAlertViewController(message: message)
            alert.delegate = self
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.show(alert, sender: nil)
        }
    }
    
    // MARK: - Selectors
    
    @objc func urlButtonTapped(_ sender: UIButton) {
        guard let index = uiview.stackView.arrangedSubviews.firstIndex(of: sender) else { return }
        guard let url = viewModel.getUrlFromMarvelURL(index: index) else { return }
        let request = URLRequest(url: url)
        let viewModel = WebViewModel(request: request)
        let webView = WebViewController(viewModel: viewModel)
        present(webView, animated: true, completion: nil)
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func favoriteButtonTapped() {
        let image = uiview.imageView.image
        let data = image?.jpegData(compressionQuality: 1.0)
        viewModel.saveHero(image: data!)
    }
}

extension DetailViewController: CustomAlertViewButtonDelegate {
    func buttonPressed() {
        closeButtonTapped()
    }
}

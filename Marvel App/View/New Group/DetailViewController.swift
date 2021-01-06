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
    
    let viewModel: DetailViewModel
    var uiview: DetailView
    
    
    // MARK: - Init
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        uiview = DetailView()
        super.init(nibName: nil, bundle: nil)
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
        
        let url = viewModel.hero.thumbnail?.url
        uiview.imageView.kf.setImage(with: URL(string: url!))
        
        let name = viewModel.hero.name
        uiview.nameLabel.text = name?.uppercased()
        
        let description = viewModel.hero.desc
        uiview.descriptionLabel.text = description?.uppercased()
        
        let types = viewModel.getTitlesURL()
        uiview.createButtonsToUrls(with: types)
        
        for button in uiview.urlButtons {
            button.addTarget(self, action: #selector(self.urlButtonTapped(_:)), for: .touchUpInside)
        }
        
    }
    
    // MARK: - Selectors
    
    @objc func urlButtonTapped(_ sender: UIButton) {
        guard let index = uiview.stackView.arrangedSubviews.firstIndex(of: sender) else { return }
        guard let url = viewModel.getUrlFromMarvelURL(index: index) else { return }
        let request = URLRequest(url: url)
        let webView = WebViewViewController(request)
        present(webView, animated: true, completion: nil)
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func favoriteButtonTapped() {
//        let image = imageView.image
    }
}

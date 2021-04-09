//
//  WebViewController.swift
//  Marvel App
//
//  Created by João Luis Santos on 19/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit


class WebViewController: UIViewController {
    
    // MARK: =============== Properties ===============
    
    let viewModel: WebViewModel
    var uiview: WebView
    
    // MARK: =============== Init ===============

    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
        uiview = WebView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: =============== View Lifecicle ===============
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiview.webview.delegate = self
        configureView()
    }
    
    override func loadView() {
        self.view = uiview
    }
    
    // MARK: =============== Functions ===============
    
    func configureView() {
        uiview.webview.loadRequest(viewModel.request)
        uiview.activityIndicator.startAnimating()
        uiview.closeButton.addTarget(self, action: #selector(self.dismissView), for: .touchUpInside)
    }
    
    // MARK: =============== Selectors ===============
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
}

// MARK: =============== UIWebViewDelegate ===============

extension WebViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        uiview.activityIndicator.stopAnimating()
    }
}

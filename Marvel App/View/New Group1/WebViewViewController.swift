//
//  WebViewViewController.swift
//  Marvel App
//
//  Created by João Luis Santos on 19/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    // MARK: - Properties
    
    private let request: URLRequest
    
    lazy var webview: UIWebView = {
        let webview = UIWebView(frame: UIScreen.main.bounds)
        return webview
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
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init

    init(_ request: URLRequest) {
        self.request = request
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.delegate = self
        setupView()
        webview.loadRequest(request)
        activityIndicator.startAnimating()
    }
    
    // MARK: - Selectors
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIWebViewDelegate

extension WebViewViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
}

// MARK: - ConfigureView

extension WebViewViewController: ConfigureView {
    func addView() {
        view.addSubview(webview)
        closeButton.addSubview(imageCloseButton)
        webview.addSubview(closeButton)
        webview.addSubview(activityIndicator)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 18),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            
            imageCloseButton.widthAnchor.constraint(equalToConstant: 25),
            imageCloseButton.heightAnchor.constraint(equalToConstant: 25),
            imageCloseButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            imageCloseButton.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: webview.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: webview.centerXAnchor)        ])
    }
    
    func additionalConfiguration() {}
    
}

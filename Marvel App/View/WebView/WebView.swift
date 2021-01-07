//
//  WebView.swift
//  Marvel App
//
//  Created by João Luis Santos on 07/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import UIKit
import WebKit

class WebView: UIView {

    lazy var webview: UIWebView = {
        let webview = UIWebView(frame: UIScreen.main.bounds)
        return webview
    }()
    
    lazy var closeButton: FloatButton = {
        let button = FloatButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ConfigureView

extension WebView: ConfigureView {
    func addView() {
        addSubview(webview)
        webview.addSubview(closeButton)
        webview.addSubview(activityIndicator)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            
            activityIndicator.centerYAnchor.constraint(equalTo: webview.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: webview.centerXAnchor)        ])
    }
    
    func additionalConfiguration() {
        closeButton.imageview.image = #imageLiteral(resourceName: "arrowLeft")
    }
    
}

//
//  CustomAlertViewController.swift
//  Marvel App
//
//  Created by João on 05/04/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import UIKit

protocol CustomAlertViewButtonDelegate {
    func buttonPressed()
}

class CustomAlertViewController: UIViewController {
    
    // MARK: =============== Properties ===============
    
    var uiview: CustomAlertView
    var delegate: CustomAlertViewButtonDelegate?
    
    // MARK: =============== Init ===============
    
    init(message: String) {
        uiview = CustomAlertView()
        uiview.messageLabel.text = message.uppercased()
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: =============== View Lifecicl ===============
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: =============== Selectors ===============
    
    @objc func buttonPressed() {
        delegate?.buttonPressed()
    }
}

// MARK: =============== ConfigureView ===============

extension CustomAlertViewController: ConfigureView {
    func addView() {
        view.addSubview(uiview)
    }
    
    func addConstraints() {
        uiview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        uiview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        uiview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        uiview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func additionalConfiguration() {
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        uiview.button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        uiview.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

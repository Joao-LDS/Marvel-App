//
//  CustomAlert.swift
//  Marvel App
//
//  Created by João on 05/04/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import UIKit

class CustomAlertView: UIView {
    
    // MARK: =============== Properties ===============

    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var button: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: =============== Init ===============

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: =============== ConfigureView ===============

extension CustomAlertView: ConfigureView {
    func addView() {
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(messageLabel)
        container.addSubview(button)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: 300),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 6),
            messageLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -6),

            button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -2),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.widthAnchor.constraint(equalToConstant: 60),
            button.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        
        container.backgroundColor = .white
        
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont(name: "Marvel-Regular", size: 24)
        messageLabel.textColor = .red
        messageLabel.textAlignment = .center
        
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = UIFont(name: "Marvel-Regular", size: 30)
        button.tintColor = .red
    }
}

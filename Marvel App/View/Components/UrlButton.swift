//
//  CustomButton.swift
//  Marvel App
//
//  Created by João Luis Santos on 26/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit

class UrlButton: UIButton {
    
    // MARK: =============== Init ===============
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: =============== ConfigureView ===============

extension UrlButton: ConfigureView {
    func addView() {}
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    func additionalConfiguration() {
        titleLabel?.font = UIFont(name: "Marvel-Regular", size: 22)
        tintColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 18
    }
}

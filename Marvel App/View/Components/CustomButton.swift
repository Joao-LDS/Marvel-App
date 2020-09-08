//
//  CustomButton.swift
//  Marvel App
//
//  Created by João Luis Santos on 26/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    private var title = ""

    init(title: String) {
        super.init(frame: .zero)
        self.title = title
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomButton: ConfigureView {
    func addView() {}
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    func additionalConfiguration() {
        setTitle(title.uppercased(), for: .normal)
        titleLabel?.font = UIFont(name: "Marvel-Regular", size: 22)
        tintColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 18
    }
}

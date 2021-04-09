//
//  FloatButton.swift
//  Marvel App
//
//  Created by João Luis Santos on 07/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import UIKit

class FloatButton: UIButton {
    
    // MARK: =============== Properties ===============

    lazy var imageview: UIImageView = {
        let view = UIImageView()
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

extension FloatButton: ConfigureView {
    func addView() {
        addSubview(imageview)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 50),
            heightAnchor.constraint(equalToConstant: 50),
            
            imageview.widthAnchor.constraint(equalToConstant: 30),
            imageview.heightAnchor.constraint(equalToConstant: 30),
            imageview.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageview.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .red
        layer.cornerRadius = 25
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = .zero
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5

    }
}

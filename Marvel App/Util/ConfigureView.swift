//
//  ConfigureView.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation
import Stevia

protocol ConfigureView {
    func addView()
    func addConstraints()
    func additionalConfiguration()
    func setupView()
}

extension ConfigureView {
    func setupView() {
        addView()
        addConstraints()
        additionalConfiguration()
    }
}

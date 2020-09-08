//
//  MarvelInfo.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation

typealias MarvelInfos = MarvelInfoData

struct MarvelInfoData: Codable {
    public var code: Int?
    public var status: String?
    public var data: MarvelDataData?
}

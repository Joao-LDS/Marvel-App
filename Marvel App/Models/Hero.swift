//
//  Hero.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation

struct Hero: Codable {
    public var id: Int?
    public var name: String?
    public var desc: String?
    public var thumbnail: HeroThumbnail?
    public var urls: [MarvelURL]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case desc = "description"
        case thumbnail = "thumbnail"
        case urls = "urls"
    }
}

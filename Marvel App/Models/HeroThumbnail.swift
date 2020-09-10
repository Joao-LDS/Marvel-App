//
//  Thumbnail.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation

struct HeroThumbnail: Codable {
    public var path: String?
    public var ext: String?
    
    var url: String {
        return "\(path!).\(ext!)"
    }
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case ext = "extension"
    }
}

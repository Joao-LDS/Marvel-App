//
//  Structs.swift
//  Marvel App
//
//  Created by João Luis Santos on 11/09/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation

struct JSON: Codable {
    var code: Int?
    var status: String?
    var data: DataOfJSON?
}

struct DataOfJSON: Codable {
    public var offset: Int?
    public var limit: Int?
    public var total: Int?
    public var count: Int?
    public var results: [Hero]?
}

struct Hero: Codable {
    public var id: Int?
    public var name: String?
    public var desc: String?
    public var thumbnail: Thumbnail?
    public var urls: [Urls]?
    public var image: Data?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case desc = "description"
        case thumbnail = "thumbnail"
        case urls = "urls"
    }
}

struct Thumbnail: Codable {
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

struct Urls: Codable {
    public var type: String?
    public var url: String?
}

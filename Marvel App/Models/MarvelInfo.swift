//
//  MarvelInfo.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation
import CoreData

struct MarvelInfo: Codable {
    var code: Int?
    var status: String?
    var data: MarvelData?

    enum CodingKeys: String, CodingKey { case code, status, data }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decode(Int.self, forKey: .code)
        status = try values.decode(String.self, forKey: .status)
        data = try values.decode(MarvelData.self, forKey: .data)
    }

    func encode(to encoder: Encoder) throws { }
}

//
//  GenericDAO.swift
//  Marvel App
//
//  Created by João on 07/04/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import Foundation

class GenericDAO {
    static func getData<T>(_ type: T.Type, from data: Data) -> T? where T: Decodable {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(type, from: data)
            return result
        } catch let error as NSError {
            debugPrint(error.description)
            return nil
        }
    }
}

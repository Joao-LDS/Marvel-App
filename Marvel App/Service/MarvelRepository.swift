//
//  MarvelAPI.swift
//  Marvel App
//
//  Created by João Luis Santos on 05/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import SwiftHash
import UIKit

class MarvelRepository {
    
    private let basePath = "https://gateway.marvel.com/v1/public/characters?"
    private let privateKey = "833c93cf646d4326ffd8593ab545dab0b98537c6"
    private let publicKey = "c002e5302091a328f109e13314d9f017"
    /* Cada página da requisição vem com um número limitado de heróis,
    esse número é dado por limitHeroForRequest. */
    private let limitHeroForRequest = 40
    
    private func parametersToAuthenticationApi() -> String {
        // Timestamp is a random number, must change on a request by request
        let timestamp = String(Date().timeIntervalSince1970)
        // Hash is created using SwiftHash, with MD5 protocol, must be lowercased.
        let hash = MD5(timestamp+privateKey+publicKey).lowercased()
        let parameters = "ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)"
        return parameters
    }
    
    func request(name: String?, page: Int = 0, completion: @escaping(Result<JSON, Failure>) -> Void) {
        /* É o range de heróis que vão retornar no JSON. Por ex, na primeira request vem os 20 primeiros,
         na segunda os próximos 20, e assim por diante. */
        let offset = limitHeroForRequest * page
        /* startsWith é um param que indica as iniciais do herói. o tratamento garante que não seja uma
         string vazia e nem que tenha espaços. */
        let startsWith: String
        if let name = name, !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: "%20"))"
        } else {
            startsWith = ""
        }
        
        let url = URL(string: basePath + "offset=\(offset)&limit=\(limitHeroForRequest)&\(startsWith)&\(parametersToAuthenticationApi())")!
        
        let failure = Failure(message: NSLocalizedString("Generic error", comment: ""))
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            let response = response as? HTTPURLResponse
            if error != nil || response?.statusCode != 200 {
                DispatchQueue.main.async { completion(.failure(failure)) }
            } else if let data = data {
                guard let jsonObject = GenericDAO.getData(JSON.self, from: data) else {
                    DispatchQueue.main.async { completion(.failure(failure)) }
                    return
                }
                DispatchQueue.main.async { completion(.success(jsonObject)) }
            }
        }
        task.resume()
    }
}

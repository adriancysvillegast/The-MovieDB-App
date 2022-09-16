//
//  APIManager.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    func get(url: String, completion: @escaping (Result<Data?,AFError>) -> Void ) {
        AF.request(url).response { response in
            completion(response.result)
        }
    }
}

//
//  APIManager.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation
import UIKit

class APIManager {
    
    static let shared = APIManager()
    
    func get(url: String, completion: @escaping (Data?) -> (), onError: @escaping (Error?) -> () ) {
        guard let url = URL(string: url) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                onError(error)
            }
            completion(data)
        }
        task.resume()
    }
}

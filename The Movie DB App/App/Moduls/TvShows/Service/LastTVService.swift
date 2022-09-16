//
//  LastTVService.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/22.
//

import Foundation

protocol LastTVServiceFetching {
    func get(onComplete: @escaping (LastTVShowResponse) -> (), onError: @escaping (String) -> () )
}

class LastTVService: LastTVServiceFetching {

    
    // MARK: - Properties
    
    private let endPointTVShowLast = ProcessInfo.processInfo.environment["endPointTVShowLast"]!
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    // MARK: - get service
    
    func get(onComplete: @escaping (LastTVShowResponse) -> (), onError: @escaping (String) -> ()) {
        APIManager.shared.get(url: "\(baseURL)\(endPointTVShowLast)api_key=\(apiKey)") { response in
            switch response{
            case .success(let data):
                guard let safeData = data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let info = try decoder.decode(LastTVShowResponse.self, from: safeData)
                    onComplete(info)
                }catch {
                    onError(error.localizedDescription)
                }
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
    
}

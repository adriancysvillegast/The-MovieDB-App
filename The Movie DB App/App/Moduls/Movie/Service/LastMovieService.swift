//
//  LastMovieService.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 4/9/22.
//

import Foundation

protocol LastMovieServiceFetching {
    func get(onComplete: @escaping (LastMovieResponse) -> (), onError: @escaping (String) -> () )
}

class LastMovieService: LastMovieServiceFetching {
    // MARK: - properties
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endPointLastMovies = ProcessInfo.processInfo.environment["endPointLastMovies"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    func get(onComplete: @escaping (LastMovieResponse) -> (), onError: @escaping (String) -> ()) {
        APIManager.shared.get(url: "\(baseURL)\(endPointLastMovies)api_key=\(apiKey)") { data in
            guard let safeData = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let info = try decoder.decode(LastMovieResponse.self, from: safeData)
                onComplete(info)
            }catch{
                onError(error.localizedDescription)
            }
        } onError: { error in
            guard let error = error else { return }
            onError(error.localizedDescription)
        }

    }
    
    
    
    
}

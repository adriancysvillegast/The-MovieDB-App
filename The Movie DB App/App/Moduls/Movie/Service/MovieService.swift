//
//  MovieService.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

protocol MovieServiceFetching {
    func get(onComplete: @escaping ([MovieResponse]) -> (), onError: @escaping (String) -> ())
}

class MovieService: MovieServiceFetching {
    
    //MARK: - properties
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endPointTopMovie = ProcessInfo.processInfo.environment["endPointTopMovie"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    //MARK: - get movies
    
    func get(onComplete: @escaping ([MovieResponse]) -> (), onError: @escaping (String) -> ()) {
        APIManager.shared.get(url: "\(baseURL)\(endPointTopMovie)api_key=\(apiKey)") { data in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let info = try decoder.decode(MoviesResponse.self, from: data)
                onComplete(info.results)
            }catch{
                onError(error.localizedDescription)
            }
        } onError: { e in
            guard let error = e else { return }
            onError(error.localizedDescription)
        }
    }
}

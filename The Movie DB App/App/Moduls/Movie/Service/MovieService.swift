//
//  MovieService.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

protocol MovieServiceFetching {
    func getMovie(onComplete: @escaping ([MovieResponse]) -> (), onError: @escaping (String) -> ())
}

class MovieService: MovieServiceFetching {
    //MARK: - properties
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endPointTopMovie = ProcessInfo.processInfo.environment["endPointTopMovie"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    //MARK: - getPopularMovies
    
    func getMovie(onComplete: @escaping ([MovieResponse]) -> (),
                          onError: @escaping (String) -> ()) {
        APIManager.shared.get(url: "\(baseURL)\(endPointTopMovie)api_key=\(apiKey)") { responde in
            guard let data = responde else { return }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let info = try decoder.decode(MoviesResponse.self, from: data)
                onComplete(info.results)
            }catch{
                onError(Constants.APIManagerErrors.error)
            }
        }
    }
}

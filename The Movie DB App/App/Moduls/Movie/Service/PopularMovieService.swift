//
//  PopularMovieService.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 4/9/22.
//

import Foundation

protocol PopularMovieServiceFeatching {
    func get(onComplete: @escaping ([PopularMovieResponse]) -> (), onError: @escaping (String) -> () )
}
class PopularMovieService: PopularMovieServiceFeatching {
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endPointPopularMovie = ProcessInfo.processInfo.environment["endPointPopularMovie"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    func get(onComplete: @escaping ([PopularMovieResponse]) -> (),
             onError: @escaping (String) -> ()) {
        print("\(baseURL)\(endPointPopularMovie)api_key=\(apiKey)")
        APIManager.shared.get(url: "\(baseURL)\(endPointPopularMovie)api_key=\(apiKey)") { data in
            guard let safeData = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let info = try decoder.decode(PopularMoviesResponse.self, from: safeData)
                onComplete(info.results)
            }catch{
                onError(error.localizedDescription)
            }
        } onError: { error in
            guard let e = error else { return }
            onError(e.localizedDescription)
        }

    }
    
}

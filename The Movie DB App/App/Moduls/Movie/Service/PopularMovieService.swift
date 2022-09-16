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
    // MARK: - properties
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endPointPopularMovie = ProcessInfo.processInfo.environment["endPointPopularMovie"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    // MARK: - get service
    
    
    
    func get(onComplete: @escaping ([PopularMovieResponse]) -> (),
             onError: @escaping (String) -> ()) {
        APIManager.shared.get(url: "\(baseURL)\(endPointPopularMovie)api_key=\(apiKey)") { response in
            switch response {
            case .success(let data):
                guard let safeData = data else { return }
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let info = try decoder.decode(PopularMoviesResponse.self, from: safeData)
                    onComplete(info.results)
                }catch{
                    onError(error.localizedDescription)
                }
                
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
    
}

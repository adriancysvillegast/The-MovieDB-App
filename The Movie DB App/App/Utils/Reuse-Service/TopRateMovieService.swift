//
//  TopRateMovieService.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

protocol TopRateMovieServiceFetching {
    func get(onComplete: @escaping ([TopRateMovieResponse]) -> (), onError: @escaping (String) -> ())
}

class TopRateMovieService: TopRateMovieServiceFetching {
    
    //MARK: - properties
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endPointTopMovie = ProcessInfo.processInfo.environment["endPointTopMovie"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    //MARK: - get service
    
    func get(onComplete: @escaping ([TopRateMovieResponse]) -> (), onError: @escaping (String) -> ()) {
        APIManager.shared.get(url: "\(baseURL)\(endPointTopMovie)api_key=\(apiKey)") { response in
            switch response{
            case .success( let data):
                guard let safeData = data else { return }
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let info = try decoder.decode(TopRateMoviesResponse.self, from: safeData)
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

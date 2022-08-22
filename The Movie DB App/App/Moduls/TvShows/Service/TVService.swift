//
//  TVService.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 20/8/22.
//

import Foundation

protocol TVServiceFetching {
    func get(onComplete: @escaping ([TVShowResponse]) -> (), onError: @escaping (String) -> ())
}

class TVService: TVServiceFetching {
    
    private let endPointTVShowPopular = ProcessInfo.processInfo.environment["endPointTVShowPopular"]!
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    func get(onComplete: @escaping ([TVShowResponse]) -> (), onError: @escaping (String) -> ()) {
        APIManager.shared.get(url: "\(baseURL)\(endPointTVShowPopular)?api_key=\(apiKey)") { data in
            guard let safeData = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let tvShow = try decoder.decode(TVShowsResponse.self, from: safeData)
                onComplete(tvShow.results)
            }catch{
                onError(error.localizedDescription)
            }
        } onError: { error in
            guard let e = error else { return}
            onError(e.localizedDescription)
        }
    }
    
    
}

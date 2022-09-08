//
//  TopRateTVService.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/22.
//

import Foundation

protocol TopRateTVServiceFetching {
    func get(onComplete: @escaping ([TopRateTVShowResponse]) -> (), onError: @escaping (String) -> ())
}
class TopRateTVService: TopRateTVServiceFetching {
    // MARK: - Properties
    
    private let endPointTVShowTopRate = ProcessInfo.processInfo.environment["endPointTVShowTopRate"]!
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    // MARK: - get service
    
    func get(onComplete: @escaping ([TopRateTVShowResponse]) -> (), onError: @escaping (String) -> ()) {
        print("\(baseURL)\(endPointTVShowTopRate)api_key=\(apiKey)")
        APIManager.shared.get(url: "\(baseURL)\(endPointTVShowTopRate)api_key=\(apiKey)") { data in
            guard let safeData = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let info = try decoder.decode(TopRateTVShowsResponse.self, from: safeData)
                onComplete(info.results)
            }catch{
                
            }
        } onError: { error in
            guard let e = error else { return }
            onError(e.localizedDescription)
        }

    }
    
    
}

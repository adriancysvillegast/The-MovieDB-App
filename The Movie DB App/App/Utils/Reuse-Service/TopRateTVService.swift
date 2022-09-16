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
        APIManager.shared.get(url: "\(baseURL)\(endPointTVShowTopRate)api_key=\(apiKey)") { response in
            switch response {
            case .success(let data):
                guard let safeData = data else { return }
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let info = try decoder.decode(TopRateTVShowsResponse.self, from: safeData)
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

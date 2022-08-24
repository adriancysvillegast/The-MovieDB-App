//
//  TVDetailService.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 22/8/22.
//

import Foundation

protocol TVDetailServiceFetching {
    func get(id: Int, onComplete: @escaping (TVShowsDetailResponse) -> (), onError: @escaping (String) -> () )
}

class TVDetailService: TVDetailServiceFetching {
    
    private let endPointSearchTV = ProcessInfo.processInfo.environment["endPointSearchTV"]!
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    func get(id: Int, onComplete: @escaping (TVShowsDetailResponse) -> (), onError: @escaping (String) -> ()) {
        APIManager.shared.get(url: "\(baseURL)\(endPointSearchTV)\(id)?api_key=\(apiKey)") { data in
            guard let safeData = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let info = try decoder.decode(TVShowsDetailResponse.self, from: safeData)
                onComplete(info)
            }catch{
                onError(error.localizedDescription)
            }
        } onError: { error in
            guard let e = error else { return }
            onError(e.localizedDescription)
        }
    }
    
}

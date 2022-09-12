//
//  CategoryService.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 10/9/22.
//

import Foundation

protocol CategoryServiceFetching {
    func get(onComplete: @escaping ([GenreMovieListResponse]) -> (), onError: @escaping (String) -> () )
}

class CategoryService: CategoryServiceFetching {
    
    // MARK: - properties
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endPointMovieCategory = ProcessInfo.processInfo.environment["endPointMovieCategory"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    // MARK: - get service
    
    func get(onComplete: @escaping ([GenreMovieListResponse]) -> (), onError: @escaping (String) -> ()) {
        APIManager.shared.get(url: "\(baseURL)\(endPointMovieCategory)api_key=\(apiKey)") { data in
            if let safeData = data{
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let info = try decoder.decode(GenresMovieListResponse.self, from: safeData)
                    onComplete(info.genres)
                }catch{
                    onError("Catch is working")
                }
            }else{
                onError("ELSE IS WORKING")
            }
        } onError: { error in
            onError("onERROR WORKING")
        }

    }
    
}

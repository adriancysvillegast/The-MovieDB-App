//
//  DetailService.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

protocol DetailServiceFetching {
    func get(with idMovie: Int, onComplete: @escaping (MovieDetailResponse) -> (), onError: @escaping (String) -> ())
}

class DetailService: DetailServiceFetching {

    //MARK: - Properties
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endPointSearchMovie = ProcessInfo.processInfo.environment["endPointSearchMovie"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    //MARK: - get Detail
    func get(with idMovie: Int, onComplete: @escaping (MovieDetailResponse) -> (), onError: @escaping (String) -> ()) {
        print("\(baseURL)\(endPointSearchMovie)\(idMovie)?api_key=\(apiKey)")
        APIManager.shared.get(url: "\(baseURL)\(endPointSearchMovie)\(idMovie)?api_key=\(apiKey)") { data in
            guard let safeData = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let info = try decoder.decode(MovieDetailResponse.self, from: safeData)
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

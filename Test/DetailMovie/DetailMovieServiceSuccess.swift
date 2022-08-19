//
//  DetailMovieServiceSuccess.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import Foundation
@testable import The_Movie_DB_App


class DetailMovieServiceSuccess: DetailServiceFetching {
    func get(with idMovie: Int, onComplete: @escaping (MovieDetailResponse) -> (), onError: @escaping (String) -> ()) {
        let url = Bundle.main.url(forResource: "detailMock", withExtension: "json")
        do{
            let decoder = JSONDecoder()
            let jsonData = try Data(contentsOf: url!)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let data = try decoder.decode(MovieDetailResponse.self, from: jsonData)
            onComplete(data)
        }catch{
            onError("")
        }
    }
    
    
}


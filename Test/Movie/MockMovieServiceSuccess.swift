//
//  MockMovieServiceSuccess.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import Foundation
@testable import The_Movie_DB_App

class MockMovieServiceSuccess: TopRateMovieServiceFetching {
    func get(onComplete: @escaping ([TopRateMovieResponse]) -> (), onError: @escaping (String) -> ()) {
        let url = Bundle.main.url(forResource: "movieMock", withExtension: "json")
        do{
            let decoder = JSONDecoder()
            let jsonData = try Data(contentsOf: url!)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let data = try decoder.decode(TopRateMoviesResponse.self, from: jsonData)
            onComplete(data.results)
        }catch{
            onError("")
        }
    }
    
}

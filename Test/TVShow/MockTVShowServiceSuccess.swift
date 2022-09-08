//
//  MockTVShowServiceSuccess.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 2/9/22.
//

import Foundation
@testable import The_Movie_DB_App

class MockTVShowServiceSuccess: PopularTVServiceFetching {
    
    func get(onComplete: @escaping ([PopularTVShowResponse]) -> (), onError: @escaping (String) -> ()) {
        let url = Bundle.main.url(forResource: "TVShowMock", withExtension: "json")
        do{
            let decoder = JSONDecoder()
            let jsonData = try Data(contentsOf: url!)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let data = try decoder.decode(PopularTVShowsResponse.self, from: jsonData)
            onComplete(data.results)
        }catch{
            onError("")
        }
        
    }
}

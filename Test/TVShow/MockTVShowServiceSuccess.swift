//
//  MockTVShowServiceSuccess.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 2/9/22.
//

import Foundation
@testable import The_Movie_DB_App

class MockTVShowServiceSuccess: TVServiceFetching {
    
    func get(onComplete: @escaping ([TVShowResponse]) -> (), onError: @escaping (String) -> ()) {
        let url = Bundle.main.url(forResource: "TVShowMock", withExtension: "json")
        do{
            let decoder = JSONDecoder()
            let jsonData = try Data(contentsOf: url!)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let data = try decoder.decode(TVShowsResponse.self, from: jsonData)
            onComplete(data.results)
        }catch{
            onError("")
        }
        
    }
}

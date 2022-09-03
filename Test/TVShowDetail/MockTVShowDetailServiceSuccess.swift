//
//  MockTVShowDetailServiceSuccess.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 2/9/22.
//

import Foundation
@testable import The_Movie_DB_App

class MockTVShowDetailServiceSuccess: TVDetailServiceFetching {
    
    func get(id: Int, onComplete: @escaping (TVShowsDetailResponse) -> (), onError: @escaping (String) -> ()) {
        let url = Bundle.main.url(forResource: "TVShowDetail", withExtension: "json")
        do{
            let data = try Data(contentsOf: url!)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let info = try decoder.decode(TVShowsDetailResponse.self, from: data)
            onComplete(info)
        }catch{
            onError("")
        }
    }
    
}

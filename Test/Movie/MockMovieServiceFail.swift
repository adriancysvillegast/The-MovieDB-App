//
//  MockMovieServiceFail.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import Foundation
@testable import The_Movie_DB_App

class MockMovieServiceFail: TopRateMovieServiceFetching {
    func get(onComplete: @escaping ([TopRateMovieResponse]) -> (), onError: @escaping (String) -> ()) {
        onError(Constants.APIManagerErrors.error)
    }
    
}

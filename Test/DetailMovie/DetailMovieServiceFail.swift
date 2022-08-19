//
//  DetailMovieServiceFail.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import Foundation
@testable import The_Movie_DB_App

class DetailMovieServiceFail: DetailServiceFetching {
    func get(with idMovie: Int, onComplete: @escaping (MovieDetailResponse) -> (), onError: @escaping (String) -> ()) {
        onError(Constants.APIManagerErrors.error)
    }
    
    
}

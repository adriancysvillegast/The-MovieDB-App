//
//  MockTVShowDetailServiceFail.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 2/9/22.
//

import Foundation
@testable import The_Movie_DB_App

class MockTVShowDetailServiceFail: TVDetailServiceFetching {
    
    func get(id: Int, onComplete: @escaping (TVShowsDetailResponse) -> (), onError: @escaping (String) -> ()) {
        onError(Constants.APIManagerErrors.error)
    }
}

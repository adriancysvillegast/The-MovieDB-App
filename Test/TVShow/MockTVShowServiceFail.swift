//
//  MockTVShowServiceFail.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 2/9/22.
//

import Foundation
@testable import The_Movie_DB_App


class MockTVShowServiceFail: PopularTVServiceFetching {
    func get(onComplete: @escaping ([PopularTVShowResponse]) -> (), onError: @escaping (String) -> ()) {
        onError(Constants.APIManagerErrors.error)
    }
}

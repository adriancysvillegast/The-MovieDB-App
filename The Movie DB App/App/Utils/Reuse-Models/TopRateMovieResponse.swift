//
//  TopRateMovieResponse.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

struct TopRateMovieResponse: Codable {
    let posterPath : String?
    let adult : Bool
    let overview : String
    let id : Int
    let originalTitle : String
    let releaseDate : String
}

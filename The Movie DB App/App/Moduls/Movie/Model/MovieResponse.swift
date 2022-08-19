//
//  MovieResponse.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

struct MovieResponse: Codable {
    let posterPath : String?
    let adult : Bool
    let overview : String
    let id : Int
    let originalTitle : String
    let releaseDate : String
}

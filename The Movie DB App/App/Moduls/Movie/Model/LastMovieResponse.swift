//
//  LastMovieResponse.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 4/9/22.
//

import Foundation

struct LastMovieResponse: Codable {
    let posterPath : String?
    let adult : Bool
    let overview : String
    let id : Int
    let originalTitle : String
    let releaseDate : String
}

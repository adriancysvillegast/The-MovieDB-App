//
//  PopularMovieResponse.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 4/9/22.
//

import Foundation

struct PopularMovieResponse: Codable {
    let posterPath: String?
    let overview: String
    let releaseDate: String
    let id: Int
    let originalTitle: String
}

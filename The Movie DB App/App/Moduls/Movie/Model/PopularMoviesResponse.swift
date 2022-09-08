//
//  PopularMoviesResponse.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 4/9/22.
//

import Foundation

struct PopularMoviesResponse: Codable {
    let results: [PopularMovieResponse]
}

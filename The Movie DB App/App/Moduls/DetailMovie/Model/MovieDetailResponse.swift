//
//  MovieDetailResponse.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

struct MovieDetailResponse: Codable {
    let adult : Bool
    let genres : [GenreResponse]
    let id : Int
    let originalLanguage : String
    let originalTitle : String
    let overview : String?
    let popularity : Float
    let posterPath : String?
    let productionCompanies: [CompaniesResponse]
    let releaseDate : String
    let voteAverage : Float
    let voteCount : Int
}

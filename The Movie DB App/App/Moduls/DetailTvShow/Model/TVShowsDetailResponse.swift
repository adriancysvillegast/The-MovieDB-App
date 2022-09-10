//
//  TVShowsDetailResponse.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 22/8/22.
//

import Foundation

struct TVShowsDetailResponse: Codable {
    let adult: Bool
    let genres: [GenreResponse]
    let numberOfEpisodes: Int?
    let numberOfSeasons: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let originalName: String
    let overview: String?
    let popularity: Float
    let posterPath: String?
    let productionCompanies: [CompaniesResponse]
    let firstAirdate: String?
}

//
//  TVShowsDetailModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 23/8/22.
//

import Foundation

struct TVShowsDetailModel {
    let adult: Bool
    let genres: [String]
    let numberOfEpisodes: Int?
    let numberOfSeasons: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Float
    let posterPath: String?
    let productionCompanies: [String]
    let imageURL: URL?
}

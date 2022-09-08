//
//  PopularTVShowResponse.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 20/8/22.
//

import Foundation

struct PopularTVShowResponse: Codable {
    let posterPath: String?
    let popularity: Float?
    let id: Int?
    let voteAverage: Float?
    let overview: String?
    let firstAirDate: String?
    let originCountry: [String]?
    let name: String?
    let originalName: String?
}

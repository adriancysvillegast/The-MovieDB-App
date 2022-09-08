//
//  TopRateTVShowResponse.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/22.
//

import Foundation

struct TopRateTVShowResponse: Codable {
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

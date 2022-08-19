//
//  DetailModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

struct DetailModel {
    let adult : Bool
    let genres : [String]
    let id : Int
    let originalLanguage : String
    let originalTitle : String
    let overview : String?
    let popularity : Float
    let posterPath : URL?
    let releaseDate : String
    let voteAverage : Float
    let voteCount : Int
    let companieImage: [URL?]
    let companieName: [String?]
}

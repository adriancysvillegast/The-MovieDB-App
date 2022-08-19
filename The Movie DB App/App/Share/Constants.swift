//
//  Constants.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

struct Constants {
    
    static let errorTitle = "ERROR!"
    
    struct APIManagerErrors {
        static let error = "We couldn't get data"
    }
    
    struct ErrorMessages {
        static let errorImagesData = "We couldn't get all images"
        static let errorGetMovies = "Hey!, we cannot get Movies"
    }

    struct ColorBackground {
        static let viewBackColorCell = "CollectionCellBackgroundColor"
        static let viewBackControllers = "BackgroundView"
    }
    
    struct ErrorDB {
        static let errorTitle = "ERROR!"
        static let readError = "We couldn't load data"
        static let saveError = "We couldn't save data"
        static let deleteError = "We couldn't delete data"
    }
}

//
//  Constants.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

struct Constants {
    
    static let errorTitle = "ERROR!"
    
    struct UserDefaultKey{
        static let token = "Token"
        static let nameUser = "User"
    }
    
    struct ImageDefault {
        static let image = "photo"
    }
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
    
    struct ValidationMessages{
        static let titleModal = " Error!"
        static let nameShort = "Please add a name with more than three character"
        static let nameWithNumbers = " Please don't used number on your name"
        static let emailError = "Please add an email addres, just like this example@gmail.com"
        static let passwordError = "Ey! type a password with more than six charater and uses numbers, lowercase and uppercase letters"
        
    }
    
    struct LabelMessage {
        static let label = "Ups, that password is not the same"
    }
    
    struct baseImage{
        static let url = "https://image.tmdb.org/t/p/w500"
    }
}


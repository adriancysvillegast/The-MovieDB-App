//
//  ProfileViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 18/8/22.
//

import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func updateName(name: String?)
    func hideMovieProperties()
    func hideTVProperties()
    func reloadTVCollection()
    func reloadMovieCollection()
}

class ProfileViewModel {
    
    //MARK: - Propertires
    
    weak var delegate: ProfileViewModelDelegate?
    weak var delegateSpinner: SpinnerLoadDelegate?
    weak var delegateError: ShowErrorDelegate?
    var movieData: [Movie] = []
    var tvShowsData: [TVShow] = []
    //MARK: - getUserName
    
    func getUserName() {
        let name = UserDefaults.standard.string(forKey: Constants.UserDefaultKey.nameUser) ?? ""
        self.delegate?.updateName(name: name)
    }
    
    
    //MARK: - getDataMovies
    
    func getMoviesFavorite() {
        self.delegateSpinner?.showSpinner()
        if let movie = DataBaseCRUD.share.getMovieSaved(){
            movieData =  movie
            self.delegate?.reloadMovieCollection()
            self.delegateSpinner?.hideSpinner()
        }else{
            self.delegateError?.showError(title: Constants.ErrorDB.errorTitle, message: Constants.ErrorDB.readError)
            self.delegateSpinner?.hideSpinner()
        }
    }

    func getMovieCount() -> Int {
        return movieData.count
    }

    func getMovieData(index: Int) -> Movie {
        return movieData[index]
    }
    
    // MARK: - GetTVShowFavorite
    
    func getTVShowFavorite() {
        self.delegateSpinner?.showSpinner()
        if let tv = DataBaseCRUD.share.getTVShowSaved() {
            self.tvShowsData = tv
            self.delegate?.reloadTVCollection()
            self.delegateSpinner?.hideSpinner()
        }else{
            self.delegate?.hideTVProperties()
            self.delegateSpinner?.hideSpinner()
        }
    }
    
    func getTVShowCount() -> Int {
        return tvShowsData.count
    }
    
    func getTVShowData(index: Int) -> TVShow {
        return tvShowsData[index]
    }
}

//
//  HomeViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 9/9/22.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func updateLastMovie(url: URL)
    func updateLastTV(url: URL)
    func updateDefaultImageLastMovie()
    func updateDefaultImageLastTV()
    func updateCollectionViewTopRateTV()
    func updateCollectionViewTopRateMovie()
    func updateCollectionViewFavoriteMovie()
    func hideCollectionViewFavoriteMovie()
}

class HomeViewModel {
    
    // MARK: - Properties
    
    var serviceLastMovie: LastMovieServiceFetching?
    var serviceTopRateTV: TopRateTVServiceFetching?
    var serviceTopRateMovie: TopRateMovieServiceFetching?
    var serviceLastTv: LastTVServiceFetching?
    weak var delegate: HomeViewModelDelegate?
    weak var delegateError: ShowErrorDelegate?
    private let baseImage = ProcessInfo.processInfo.environment["baseImage"]!
    var topRateTv: [TopRateTVShowResponse] = []
    var topRateMovie: [TopRateMovieResponse] = []
    var favoriteMovie: [Movie] = []
    // MARK: - init
    init(serviceLastMovie: LastMovieServiceFetching = LastMovieService(), serviceTopRateTV: TopRateTVServiceFetching = TopRateTVService(), serviceTopRateMovie: TopRateMovieServiceFetching = TopRateMovieService(), serviceLastTV: LastTVServiceFetching? = LastTVService() ) {
        self.serviceLastMovie = serviceLastMovie
        self.serviceTopRateTV = serviceTopRateTV
        self.serviceTopRateMovie = serviceTopRateMovie
        self.serviceLastTv = serviceLastTV
    }
    
    // MARK: - get Last Movie
    
    func getLastMovie() {
        serviceLastMovie?.get(onComplete: { lastMovie in
            if let path = lastMovie.posterPath{
                guard let url = URL(string: "\(self.baseImage)\(path)") else { return }
            self.delegate?.updateLastMovie(url: url)
            }else {
                self.delegate?.updateDefaultImageLastMovie()
            }
        }, onError: { error in
            self.delegateError?.showError(title: Constants.errorTitle, message: error)
            self.delegate?.updateDefaultImageLastMovie()
        })
    }
    
    // MARK: - get Top Rate TVShow
    
    func getTopRateTv() {
        serviceTopRateTV?.get(onComplete: { shows in
            self.topRateTv = shows
            self.delegate?.updateCollectionViewTopRateTV()
        }, onError: { error in
            self.delegateError?.showError(title: Constants.errorTitle, message: error)
        })
    }
    
    func getTopRateTVCount() -> Int {
        return topRateTv.count
    }
    
    func getTopRateTVData(index: Int) -> TopRateTVShowResponse {
        return topRateTv[index]
    }
    
    // MARK: - get Top Rate Movie
    
    func getTopRateMovie() {
        serviceTopRateMovie?.get(onComplete: { movies in
            self.topRateMovie = movies
            self.delegate?.updateCollectionViewTopRateMovie()
        }, onError: { error in
            self.delegateError?.showError(title: Constants.errorTitle, message: error)
        })
    }
    
    func getTopRateMovieCount() -> Int {
        return topRateMovie.count
    }
    
    func getTopRateMovieData(index: Int) -> TopRateMovieResponse {
        return topRateMovie[index]
    }
    
    // MARK: - get Favorite Movies
    
    func getFavoriteMovies() {
        if let favMovie = DataBaseCRUD.share.readData(){
            self.favoriteMovie = favMovie
            self.delegate?.updateCollectionViewFavoriteMovie()
        }else{
            self.delegate?.hideCollectionViewFavoriteMovie()
        }
    }
    
    func getFavoriteMovieCount() -> Int {
        return favoriteMovie.count
    }
    
    func getFavoriteMoviData(index: Int) -> Movie {
        return favoriteMovie[index]
    }
    
    // MARK: - get Last Tv
    
    func getLastTv() {
        serviceLastTv?.get(onComplete: { lastTV in
            if let path = lastTV.posterPath {
                print(path)
                guard let url = URL(string: "\(self.baseImage)\(path)") else { return }
                self.delegate?.updateLastTV(url: url)
            }else{
                self.delegate?.updateDefaultImageLastTV()
            }
    
        }, onError: { error in
            self.delegateError?.showError(title: Constants.errorTitle, message: error)
        })
    }
}

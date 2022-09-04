//
//  MovieViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

protocol MovieViewModelDelegate: AnyObject {
    func updateView()
    func updateLastMovie(url: URL)
}

class MovieViewModel {
    //MARK: - Properties
    
    private let baseImage = ProcessInfo.processInfo.environment["baseImage"]!
    var serviceTopRate: TopRateMovieServiceFetching?
    var serviceLastMovie: LastMovieServiceFetching?
    weak var delegate: MovieViewModelDelegate?
    weak var delegateSpinner: SpinnerLoadDelegate?
    weak var delegateError: ShowErrorDelegate?
    
    var moviesTopRateData: [TopRateMovieResponse] = []
    
    //MARK: - Init
    
    init(serviceTopRate: TopRateMovieServiceFetching = TopRateMovieService(), serviceLastMovie: LastMovieServiceFetching = LastMovieService()) {
        self.serviceTopRate = serviceTopRate
        self.serviceLastMovie = serviceLastMovie
    }
    
    //MARK: - getTopRateMovies
    
    func getMovies() {
        self.delegateSpinner?.showSpinner()
        serviceTopRate?.get(onComplete: { data in
            self.moviesTopRateData = data
            self.delegateSpinner?.hideSpinner()
            self.delegate?.updateView()
        }, onError: { error in
            self.delegateSpinner?.hideSpinner()
            self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ErrorMessages.errorGetMovies)
        })
    }
    
    //MARK: - ShowTopRateMoviesData

    func getMovieCount() -> Int {
        return moviesTopRateData.count
    }
    
    func getMovieData(index: Int) -> TopRateMovieResponse {
        return moviesTopRateData[index]
    }
    
    // MARK: - getLastMovieData
    
    func getLastMovie() {
        self.delegateSpinner?.showSpinner()
        serviceLastMovie?.get(onComplete: { lastMovie in
            if let path = lastMovie.posterPath {
                guard let url = URL(string: "\(self.baseImage)\(path)") else { return }
                self.delegate?.updateLastMovie(url: url)
            }else{
                if let path = self.moviesTopRateData[0].posterPath{
                    guard let url = URL(string: "\(self.baseImage)\(path)") else { return }
                    self.delegate?.updateLastMovie(url: url)
                }
            }
            self.delegateSpinner?.hideSpinner()
        }, onError: { error in
            self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ErrorMessages.errorGetMovies)
            self.delegateSpinner?.hideSpinner()
        })
    }
}


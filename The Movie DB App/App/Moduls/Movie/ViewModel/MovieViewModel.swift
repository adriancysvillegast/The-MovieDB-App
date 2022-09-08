//
//  MovieViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

protocol MovieViewModelDelegate: AnyObject {
    func updateTopRateCollection()
    func updatePopularCollection()
    func updateLastMovie(url: URL)
}

class MovieViewModel {
    //MARK: - Properties
    
    private let baseImage = ProcessInfo.processInfo.environment["baseImage"]!
    var serviceTopRate: TopRateMovieServiceFetching?
    var serviceLastMovie: LastMovieServiceFetching?
    var servicePopularMovie: PopularMovieServiceFeatching?
    weak var delegate: MovieViewModelDelegate?
    weak var delegateSpinner: SpinnerLoadDelegate?
    weak var delegateError: ShowErrorDelegate?
    
    var serviceTopRateSuccess: Bool = false
    var servicePopularSuccess: Bool = false
    
    var moviesTopRateData: [TopRateMovieResponse] = []
    var moviesPopularData: [PopularMovieResponse] = []
    //MARK: - Init
    
    init(serviceTopRate: TopRateMovieServiceFetching = TopRateMovieService(), serviceLastMovie: LastMovieServiceFetching = LastMovieService(), servicePopularMovie: PopularMovieServiceFeatching = PopularMovieService() ) {
        self.serviceTopRate = serviceTopRate
        self.serviceLastMovie = serviceLastMovie
        self.servicePopularMovie = servicePopularMovie
    }
    
    // MARK: - get all services
    
    func getAllService() {
        
    }
    
    //MARK: - getTopRateMovies
    
    func getTopRateMovies() {
        self.delegateSpinner?.showSpinner()
        serviceTopRate?.get(onComplete: { data in
            self.moviesTopRateData = data
            self.delegateSpinner?.hideSpinner()
            self.delegate?.updateTopRateCollection()
        }, onError: { error in
            self.delegateSpinner?.hideSpinner()
            self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ErrorMessages.errorGetMovies)
        })
    }
    
    //MARK: - ShowTopRateMoviesData

    func getTopRateMovieCount() -> Int {
        return moviesTopRateData.count
    }
    
    func getTopRateMovieData(index: Int) -> TopRateMovieResponse {
        return moviesTopRateData[index]
    }
    
    // MARK: - getLastMovieData
    
    func getLastMovie() {
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
    
    
    // MARK: - Get Popular Movies
    
    func getPopularMovie() {
        servicePopularMovie?.get(onComplete: { infoMovies in
            self.moviesPopularData = infoMovies
            self.delegate?.updatePopularCollection()
        }, onError: { error in
            print(error)
        })
    }
    
    // MARK: - ShowPopularMovieData
    
    func popularMoviesCount() -> Int {
        return moviesPopularData.count
    }

    func getPopularMovieData(index: Int) -> PopularMovieResponse {
        return moviesPopularData[index]
    }
    
}


//
//  MovieViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

protocol MovieViewModelDelegate: AnyObject {
    func updateView()
}

class MovieViewModel {
    //MARK: - Properties
    
    var service: MovieServiceFetching?
    weak var delegate: MovieViewModelDelegate?
    weak var delegateSpinner: SpinnerLoadDelegate?
    weak var delegateError: ShowErrorDelegate?
    
    var movieData: [MovieResponse] = []
    var movieArray: [MovieModel] = []
    
    //MARK: - Init
    
    init(service: MovieServiceFetching = MovieService()) {
        self.service = service
    }
    
    //MARK: - getMovies

    func getMovies() {
        movieArray = []
        self.delegateSpinner?.showSpinner()
        service?.get(onComplete: { data in
            self.movieData = data
            self.delegateSpinner?.hideSpinner()
            self.delegate?.updateView()
        }, onError: { error in
            self.delegateSpinner?.hideSpinner()
            self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ErrorMessages.errorGetMovies)
        })
    }
    
    //MARK: - ShowData

    func getMovieCount() -> Int {
        return movieData.count
    }
    
    func getMovieData(index: Int) -> MovieResponse {
        return movieData[index]
    }
    
}


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
    
    private var service: MovieServiceFetching?
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
        service?.getMovie(onComplete: { movie in
            self.createMovie(movie: movie)
            self.delegate?.updateView()
        }, onError: { error in
            self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ErrorMessages.errorGetMovies)
        })
        
    }
    
    func createMovie(movie: [MovieResponse]) {
        for movie in movie {
            let dataImage = getDataImage(url: movie.posterPath)
            let newMovie = MovieModel(imageData: dataImage, adult: movie.adult, overview: movie.overview, id: movie.id, originalTitle: movie.originalTitle, releaseDate: movie.releaseDate)
            movieArray.append(newMovie)
        }
    }
    //MARK: - getDataImage
    
    private func getDataImage(url: String?) -> Data?{
        var data: Data?
        let baseImage = ProcessInfo.processInfo.environment["baseImage"]!
        if let safeURL = url{
            if let url = URL(string: "\(baseImage)\(safeURL)") {
                do{
                    data = try Data(contentsOf: url)
                }catch{
                    print(Constants.ErrorMessages.errorImagesData)
                }
            }
        }
        return data
    }

    //MARK: - ShowData

    func getMovieCount() -> Int {
        return movieArray.count
    }
    
    func getMovieData(index: Int) -> MovieModel {
        return movieArray[index]
    }
    
}


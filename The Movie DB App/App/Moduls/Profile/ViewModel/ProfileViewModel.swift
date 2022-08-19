//
//  ProfileViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 18/8/22.
//

import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func updateName(name: String?)
}

class ProfileViewModel {
    
    //MARK: - Propertires
    
    weak var delegate: ProfileViewModelDelegate?
    weak var delegateSpinner: SpinnerLoadDelegate?
    weak var delegateError: ShowErrorDelegate?
    
    var movieData: [MovieModel] = []
    
    //MARK: - getUserName
    
    func getUserName() {
        let name = UserDefaults.standard.string(forKey: Constants.UserDefaultKey.nameUser) ?? ""
        self.delegate?.updateName(name: name)
    }
    
    
    //MARK: - getDataMovies
    
    func getFavoriteMovies() {
        self.delegateSpinner?.showSpinner()
        if let dataOnDB = DataBaseCRUD.share.readData(){
            movieData =  createObject(movie: dataOnDB)
            self.delegateSpinner?.hideSpinner()
        }else{
            self.delegateError?.showError(title: Constants.ErrorDB.errorTitle, message: Constants.ErrorDB.readError)
            self.delegateSpinner?.hideSpinner()
        }
    }
    
    func createObject(movie: [Movie]) -> [MovieModel] {
        var movies: [MovieModel] = []
        for movie in movie {
            let data = getDataImage(url: movie.imageMovie)
            let newObject = MovieModel(imageData: data, adult: movie.adult, overview: movie.descriptionMovie ?? "", id: Int(movie.id), originalTitle: movie.title ?? "", releaseDate: movie.releaseDate ?? "")
            movies.append(newObject)
        }
        return movies
    }
    
    func getDataImage(url: String?) -> Data? {
        var data: Data?
        if let safeURL = url{
            guard let url = URL(string: safeURL) else { return nil }
            do{
                data = try Data(contentsOf: url)
            }catch{
                self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ErrorMessages.errorImagesData)
            }
        }
        return data
    }
    
    func getCountData() -> Int {
        return movieData.count
    }
    
    func getMovieData(index: Int) -> MovieModel {
        return movieData[index]
    }
    
}

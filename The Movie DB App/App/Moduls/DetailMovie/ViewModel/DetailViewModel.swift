//
//  DetailViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func updateView(data: DetailModel)
    func updateCollection()
}

class DetailViewModel {
    
    //MARK: - Properties
    
    private let baseImage = ProcessInfo.processInfo.environment["baseImage"]!
    var service: DetailServiceFetching?
    weak var delegate: DetailViewModelDelegate?
    weak var delegateSpinner: SpinnerLoadDelegate?
    weak var delegateError: ShowErrorDelegate?
    
    var companieArray: [CompaniesResponse] = []
    var movieSelect: DetailModel?
    
    //MARK: - init
    
    init(service: DetailServiceFetching = DetailService()) {
        self.service = service
    }
    
    //MARK: - getData
    
    func getdetails(idMovie: Int?) {
        guard let idMovie = idMovie else {
            return
        }
        self.delegateSpinner?.showSpinner()
        service?.get(with: idMovie, onComplete: { data in
            let info = self.createDetailModel(data: data)
            self.movieSelect = info
            self.companieArray = data.productionCompanies
            self.delegate?.updateView(data: info)
            self.delegate?.updateCollection()
            self.delegateSpinner?.hideSpinner()
        }, onError: { error in
            self.delegateSpinner?.hideSpinner()
            self.delegateError?.showError(title: Constants.errorTitle, message: error)
        })
    }
    
    private func createDetailModel(data: MovieDetailResponse) -> DetailModel {
        var genres: [String] = []
        let url = URL(string: "\(baseImage)\(data.posterPath ?? "")")
        
        for data in data.genres {
            genres.append(data.name)
        }
        
        let nameCompanies = nameCompanies(data: data)
        let urlComapanie = imageCompanies(data: data)
        
        let newData = DetailModel(adult: data.adult, genres: genres, id: data.id, originalLanguage: data.originalLanguage, originalTitle: data.originalTitle, overview: data.overview, popularity: data.popularity, posterPath: url , releaseDate: data.releaseDate, voteAverage: data.voteAverage, voteCount: data.voteCount, companieImage: urlComapanie, companieName: nameCompanies)
        return newData
    }
    
    func imageCompanies(data: MovieDetailResponse) -> [URL?] {
        var imageCompanie: [URL?] = []
        for data in data.productionCompanies {
            if let link = data.logoPath{
                let url = URL(string: "\(baseImage)\(link)")
                imageCompanie.append(url)
            }
        }
        return imageCompanie
    }
    
    func nameCompanies(data: MovieDetailResponse) -> [String?] {
        var nameCompanie: [String?] = []
        for data in data.productionCompanies {
            if let name = data.name{
                nameCompanie.append(name)
            }
        }
        return nameCompanie
    }
    
    //MARK: - companies data
    
    func companiesCount() -> Int {
        companieArray.count
    }
    
    func showCompaniesData(index: Int) -> CompaniesResponse {
        companieArray[index]
    }
    
    
    //MARK: - add Favorite
    func saveMovie() {
        guard let movieSelect = movieSelect else {
            return
        }
        
        if DataBaseCRUD.share.createObjec(movie: movieSelect){
            self.delegateError?.showError(title: "\(movieSelect.originalTitle) was added to favorite List", message: "")
        }else{
            self.delegateError?.showError(title: "Error saving Movie", message: "")
        }
    }
    
}

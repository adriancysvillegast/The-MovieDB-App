//
//  TVDetailViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 22/8/22.
//

import Foundation

protocol TVDetailViewModelDelegate: AnyObject {
    func updateView(model: TVShowsDetailModel)
    func reloadCollection()
}

class TVDetailViewModel {

    //MARK: - properties

    private let baseImage = ProcessInfo.processInfo.environment["baseImage"]!
    weak var delegate: TVDetailViewModelDelegate?
    weak var delegateSpinner: SpinnerLoadDelegate?
    weak var delegateError: ShowErrorDelegate?
    var service: TVDetailServiceFetching?
    var tvShowCompanies: [CompaniesResponse] = []
    var tvSelected: TVShowsDetailResponse?
    
    //MARK: - init
    init(service: TVDetailServiceFetching = TVDetailService()) {
        self.service = service
    }
    
    //MARK: - getData
    
    func getData(id: Int?) {
        self.delegateSpinner?.showSpinner()
        guard let id = id else {
            return
        }

        service?.get(id: id, onComplete: { data in
            self.tvSelected = data
            let info = self.createObject(show: data)
            self.tvShowCompanies = data.productionCompanies
            self.delegate?.updateView(model: info)
            self.delegateSpinner?.hideSpinner()
            self.delegate?.reloadCollection()
        }, onError: { e in
            self.delegateSpinner?.hideSpinner()
            self.delegateError?.showError(title: Constants.errorTitle, message: e)
        })
    }
    
    private func createObject(show: TVShowsDetailResponse) -> TVShowsDetailModel {
        let genres = getGenres(show: show)
        let companiesImage = getCompanies(show: show)
        let imageShow = getImageURL(show: show)
        let url = URL(string: "\(baseImage)\(show.posterPath ?? "" )")
        let newObject = TVShowsDetailModel(adult: show.adult, genres: genres, numberOfEpisodes: show.numberOfEpisodes, numberOfSeasons: show.numberOfSeasons, originalLanguage: show.originalLanguage, originalTitle: show.originalName, overview: show.overview, popularity: show.popularity, posterPath: imageShow, productionCompanies: companiesImage, imageURL: url, firstAirDate: show.firstAirdate)
        return newObject
    }

    private func getGenres(show: TVShowsDetailResponse) -> [String] {
        var genres: [String] = []
        for show in  show.genres {
            genres.append(show.name)
        }
        return genres
    }
    
    private func getCompanies(show: TVShowsDetailResponse) -> [String] {
        var image: [String] = []
        for show in show.productionCompanies {
            let url = "\(baseImage)\(show.logoPath)"
            image.append(url)
        }
        return image
    }
    
    private func getImageURL(show: TVShowsDetailResponse) -> String {
        var image: String = ""
        
        if let url = show.posterPath {
            image = "\(baseImage)\(url)"
        }else {
           image = ""
        }
        return image
    }
    
    
    //MARK: - get count companies
    
    func getCompaniesCount() -> Int {
        return tvShowCompanies.count
    }
    
    func getCompaniesData(index: Int) -> CompaniesResponse {
        return tvShowCompanies[index]
    }
    
    // MARK: - Save TVShow
    
    func saveTv() {
        if let tvSelected = tvSelected {
            if DataBaseCRUD.share.saveTVShow(model: tvSelected){
                self.delegateError?.showError(title: "\(String(describing: tvSelected.originalName)) was added to favorite list", message: "")
            }else{
                self.delegateError?.showError(title: "Error saving TV Show", message: "")
            }
        }
    }
    
}



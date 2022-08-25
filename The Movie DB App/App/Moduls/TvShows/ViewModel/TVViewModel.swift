//
//  TVViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 20/8/22.
//

import Foundation

protocol TVViewModelDelegate: AnyObject {
    func updateCollection()
}

class TVViewModel {
    //MARK: - properties
    
    var service: TVServiceFetching?
    weak var delegate: TVViewModelDelegate?
    weak var delegateSpinner: SpinnerLoadDelegate?
    weak var delegateError: ShowErrorDelegate?
    var showData: [TVShowModel] = []
    
    init(service: TVServiceFetching = TVService()) {
        self.service = service
    }
    
    //MARK: - get tv shows
    
    func getTVData() {
        self.delegateSpinner?.showSpinner()
        service?.get(onComplete: { shows in
            self.createObject(show: shows)
            self.delegate?.updateCollection()
            self.delegateSpinner?.hideSpinner()
        }, onError: { error in
            self.delegateError?.showError(title: Constants.errorTitle, message: error)
            self.delegateSpinner?.hideSpinner()
        })
    }
    
    //MARK: - createObject
    
    private func createObject(show: [TVShowResponse]) {
        for show in show {
            let url = createURL(url: show.posterPath)
            let data = getDataImage(url: url)
            let newShow = TVShowModel(posterPath: url, popularity: show.popularity, id: show.id, voteAverage: show.voteAverage, overview: show.overview, firstAirDate: show.firstAirDate, originCountry: show.originCountry, name: show.name, originalName: show.originalName, imageData: data)
            showData.append(newShow)
        }
    }
    
    private func createURL(url: String?) -> String? {
        if let url = url {
            return "\(Constants.baseImage.url)\(url)"
        }else{
            return ""
        }
    }
    
    private func getDataImage(url: String?) -> Data? {
        var data: Data?
        guard let url = url else { return nil }
            if let safeURL = URL(string: url){
                do{
                    data = try Data(contentsOf: safeURL)
                }catch {
                    self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ErrorMessages.errorImagesData)
                }
            }
     return data
    }

    //MARK: - ShowData
    
    func getCount() -> Int {
        return showData.count
    }
    
    func getDataTV(index: Int) -> TVShowModel {
        return showData[index]
    }
}



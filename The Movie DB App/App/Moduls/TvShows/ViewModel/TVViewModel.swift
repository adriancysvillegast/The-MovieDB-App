//
//  TVViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 20/8/22.
//

import Foundation

protocol TVViewModelDelegate: AnyObject {
    func updatePopularCollection()
    func updateTopRateCollection()
    func updateLastShow(url: URL)
}

class TVViewModel {
    //MARK: - properties
    private let baseImage = ProcessInfo.processInfo.environment["baseImage"]!
    var popularService: PopularTVServiceFetching?
    var lastService: LastTVServiceFetching?
    var topRateService: TopRateTVServiceFetching?
    weak var delegate: TVViewModelDelegate?
    weak var delegateSpinner: SpinnerLoadDelegate?
    weak var delegateError: ShowErrorDelegate?
    var popularTVShow: [PopularTVShowResponse] = []
    var topRateTVShow: [TopRateTVShowResponse] = []
    
    init(popularService: PopularTVServiceFetching = PopularTVService(), lastService: LastTVServiceFetching = LastTVService(), topRateService: TopRateTVServiceFetching = TopRateTVService() ) {
        self.popularService = popularService
        self.lastService = lastService
        self.topRateService = topRateService
    }
    
    //MARK: - get popular tv shows
    
    func getPopularTVShows() {
        self.delegateSpinner?.showSpinner()
        popularService?.get(onComplete: { shows in
            self.popularTVShow = shows
            self.delegate?.updatePopularCollection()
            self.delegateSpinner?.hideSpinner()
        }, onError: { error in
            self.delegateError?.showError(title: Constants.errorTitle, message: error)
            self.delegateSpinner?.hideSpinner()
        })
    }
    
    func getPopularCount() -> Int {
        return popularTVShow.count
    }
    
    func getPopularData(index: Int) -> PopularTVShowResponse {
        return popularTVShow[index]
    }
    
    // MARK: - get last TvShow
    
    func getLastTVShow() {
        lastService?.get(onComplete: { lastShow in
            if let path = lastShow.posterPath {
                guard let url = URL(string: "\(self.baseImage)\(path)") else { return }
                self.delegate?.updateLastShow(url: url)
            }else{
                if let path = self.popularTVShow[0].posterPath{
                    guard let url = URL(string: "\(self.baseImage)\(path)") else { return }
                    self.delegate?.updateLastShow(url: url)
                }
            }
        }, onError: { error in
            self.delegateError?.showError(title: Constants.errorTitle, message: error)
        })
    }
    
    
    // MARK: - get top rate tv show
    
    func getTopRateTVShows() {
        topRateService?.get(onComplete: { show in
            self.topRateTVShow = show
            self.delegate?.updateTopRateCollection()
        }, onError: { error in
            self.delegateError?.showError(title: Constants.errorTitle, message: error)
        })
    }
    
    func getTopRateCount() -> Int {
        return topRateTVShow.count
    }
    
    func getTopRateData(index: Int) -> TopRateTVShowResponse {
        return topRateTVShow[index]
    }
    
}



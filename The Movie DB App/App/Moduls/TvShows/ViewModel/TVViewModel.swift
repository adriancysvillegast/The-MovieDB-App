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
    var showData: [TVShowResponse] = []
    
    init(service: TVServiceFetching = TVService()) {
        self.service = service
    }
    
    //MARK: - get tv shows
    
    func getTVData() {
        self.delegateSpinner?.showSpinner()
        service?.get(onComplete: { shows in
            self.showData = shows
            self.delegate?.updateCollection()
            self.delegateSpinner?.hideSpinner()
        }, onError: { error in
            self.delegateError?.showError(title: Constants.errorTitle, message: error)
            self.delegateSpinner?.hideSpinner()
        })
    }

    //MARK: - ShowData
    
    func getCount() -> Int {
        return showData.count
    }
    
    func getDataTV(index: Int) -> TVShowResponse {
        return showData[index]
    }
}



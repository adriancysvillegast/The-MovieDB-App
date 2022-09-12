//
//  CategoryViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 10/9/22.
//

import Foundation

protocol CategoryViewModelDelegate: AnyObject {
    func reloadTable()
}

class CategoryViewModel {
    // MARK: - Properties
    var service: CategoryServiceFetching?
    weak var delegateError: ShowErrorDelegate?
    weak var delegate: CategoryViewModelDelegate?
    var genresData: [GenreMovieListResponse] = []
    
    // MARK: - init
    
    init(service: CategoryServiceFetching = CategoryService()) {
        self.service = service
    }
    
    
    // MARK: - GET Categories
    
    func getCategories() {
        genresData = []
        service?.get(onComplete: { genres in
            self.genresData = genres
            self.delegate?.reloadTable()
        }, onError: { error in
            self.delegateError?.showError(title: Constants.errorTitle, message: error)
        })
    }
    
    func getCategoryCount() -> Int {
        return genresData.count
    }
    
    func getCategoryData(index: Int) -> GenreMovieListResponse {
        return genresData[index]
    }
}

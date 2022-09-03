//
//  MovieTest.swift
//  MovieTest
//
//  Created by Adriancys Jesus Villegas Toro on 18/8/22.
//

import XCTest
@testable import The_Movie_DB_App

class MovieTest: XCTestCase {

    var sut: MovieViewModel!
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_MovieViewModel_ShouldReturnError() {
        let mock = MockMovieServiceFail()
        sut = MovieViewModel(service: mock)
        
        sut.service?.get(onComplete: { movie in
            XCTAssertTrue(movie.isEmpty)
        }, onError: { error in
            XCTAssertEqual(error, Constants.APIManagerErrors.error)
        })
    }
    
    func test_MovieViewModel_ShouldReturnData() {
        let mock = MockMovieServiceSuccess()
        
        sut =  MovieViewModel(service: mock)
        
        sut.service?.get(onComplete: { movie in
            XCTAssertTrue(movie.count > 0)
        }, onError: { error in
            XCTAssertEqual(error, "")
        })
    }

}

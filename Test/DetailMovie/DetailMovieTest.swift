//
//  DetailMovieTest.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import XCTest
@testable import The_Movie_DB_App

class DetailMovieTest: XCTestCase {

    var sut: DetailViewModel!
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_DetailMovieView_ShouldReturnError() {
        let mock = DetailMovieServiceFail()
        
        sut = DetailViewModel(service: mock)
            
        sut.service?.get(with: 131296, onComplete: { data in
            XCTAssertNil(data)
        }, onError: { error in
            XCTAssertEqual("We couldn't get data", Constants.APIManagerErrors.error)
        })
        
    }
    
    func test_DetailMovieView_ShouldReturnData() {
        let mock = DetailMovieServiceSuccess()
        
        sut =  DetailViewModel(service: mock)
        
        sut.service?.get(with: 131296, onComplete: { data in
            XCTAssertNotNil(data)
        }, onError: { error in
            XCTAssertEqual("", "")
        })
    }

    
}

//
//  TVShowTest.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 2/9/22.
//

import XCTest
@testable import The_Movie_DB_App

class TVShowTest: XCTestCase {

    var sut: TVViewModel!
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_TVViewModel_ShouldReturnData() {
        let mock = MockTVShowServiceSuccess()
        
        sut =  TVViewModel(service: mock)
        
        sut.service?.get(onComplete: { movie in
            XCTAssertTrue(movie.count > 0)
        }, onError: { error in
            XCTAssertEqual(error, "")
        })
    }
    
    func test_TVViewModel_ShouldReturnError() {
        let mock = MockTVShowServiceFail()
        
        sut =  TVViewModel(service: mock)
        
        sut.service?.get(onComplete: { movie in
            XCTAssertTrue(movie.isEmpty)
        }, onError: { error in
            XCTAssertEqual(error,Constants.APIManagerErrors.error )
        })
    }
    
}

//
//  TVShowDetailTest.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 2/9/22.
//

import XCTest
@testable import The_Movie_DB_App

class TVShowDetailTest: XCTestCase {

    var sut : TVDetailViewModel!
    
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_TVShowDetail_Should_Return_Error() {
        let mock = MockTVShowDetailServiceFail()
        
        sut = TVDetailViewModel(service: mock)
        sut.service?.get(id: 237053, onComplete: { detail in
            XCTAssertNil(detail)
        }, onError: { error in
            XCTAssertEqual("We couldn't get data", Constants.APIManagerErrors.error)
        })
    }
    
    func test_TVShowDetail_Should_Return_Data() {
        let mock = MockTVShowDetailServiceSuccess()
        
        sut = TVDetailViewModel(service: mock)
        
        sut.service?.get(id: 237053, onComplete: { detail in
            XCTAssertNotNil(detail)
        }, onError: { error in
            XCTAssertEqual("", "")
        })
    }
}

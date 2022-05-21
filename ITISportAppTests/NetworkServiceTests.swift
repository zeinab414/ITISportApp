//
//  NetworkServiceTests.swift
//  ITISportAppTests
//
//  Created by zeinab ibrahim on 5/21/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import XCTest
//@testable import ITISportApp
@testable import ITISportApp

class NetworkServiceTests: XCTestCase {
    var networkService:SportService = NetworkService()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testFetchSportResultWithAF(){
        let myExpection = expectation(description: "wait of api"); networkService.fetchSportResultWithAF { (items) in
            guard let items=items else{
                XCTFail()
                return
            }
        XCTAssertEqual(items.count, 34)
            myExpection.fulfill()
            
        }
        waitForExpectations(timeout: 15, handler: nil)
    }

    func testFetchSLeagesResultWithAF(){
         let myExpection = expectation(description:"wait of api");
        networkService.fetchSLeagesResultWithAF(endPoint: "Soccer") { (items) in
            guard let items=items else{
                XCTFail()
                return
            }
        XCTAssertEqual(items.count, 10)
            myExpection.fulfill()
            
        }
        waitForExpectations(timeout: 15, handler: nil)
    }
    func testFetchTeamsResultWithAF(){
         let myExpection = expectation(description:"wait of api");
        networkService.fetchTeamsResultWithAF(endPoint: "BTCC") { (items) in
            guard let items=items else{
                XCTFail()
                return
            }
        XCTAssertEqual(items.count, 14)
            myExpection.fulfill()
            
        }
        waitForExpectations(timeout: 15, handler: nil)
    }
}

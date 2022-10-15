//
//  Networking.swift
//  Books AppTests
//
//  Created by Berkay on 15.10.2022.
//

import XCTest

@testable import Books_App

final class NetworkTest: XCTestCase {

    var httpClient: NetworkingProtocol!

    override func setUp() {

        super.setUp()
        httpClient = BookNetwork()
    }

    override func tearDown() {

        super.tearDown()
    }

    func test_get_request_withURL() {
        // Given
        let BookRequestModel: BookRequestModel = BookRequestModel(paginationTotal: 20)
        let expectation = expectation(description: "waiting for load function")
        // When
        httpClient.requestData(request: BookRequestModel) { (result: Result<Welcome, Error>) in

            switch result {
            case .success(let success):
                XCTAssertTrue(true,"expected Succeded  \(success)")
                let result = success.feed?.results
                XCTAssertEqual(result?.count, 20)
            case .failure(let failure):
                XCTFail("expected error but recieved \(failure) ")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func test_get_request_withError() {
        // Given
        let BookRequestModel: TestNetworkingRequestModel = TestNetworkingRequestModel(paginationTotal: 30)
        let expectation = expectation(description: "waiting for load function")
        // When
        httpClient.requestData(request: BookRequestModel) { (result: Result<Welcome, Error>) in

            switch result {
            case .success(let success):
                XCTFail("expected error but recieved \(success) ")

            case .failure(let failure):
                XCTAssertTrue(true,"expected Succeded  \(failure)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
}




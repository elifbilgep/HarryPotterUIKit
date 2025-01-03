//
//  HarryPotterTests.swift
//  HarryPotterTests
//
//  Created by Elif Parlak on 3.01.2025.
//

import XCTest
@testable import HarryPotter

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = HomeViewModel(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchHouses_Success() {
        // Given
        let expectation = XCTestExpectation(description: "Houses fetched successfully")
        
        // Prepare mock JSON response for houses
        let jsonResponse = TestData.validJSONResponse
        mockNetworkService.mockResponse = jsonResponse.data(using: .utf8)
        
        // Set up the viewModel to call the update closures
        viewModel.onHousesUpdated = {
            XCTAssertEqual(self.viewModel.numberOfHouses, 3)
            XCTAssertEqual(self.viewModel.house(at: 0).house, "Gryffindor")
            XCTAssertEqual(self.viewModel.house(at: 1).house, "Hufflepuff")
            XCTAssertEqual(self.viewModel.house(at: 2).house, "Ravenclaw")
            expectation.fulfill()
        }
        
        // When
        viewModel.fetchHouses()
        
        // Then
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchHouses_Failure() {
        // Given
        mockNetworkService.shouldReturnError = true
        mockNetworkService.errorType = .serverError("Server is down")
        let expectation = XCTestExpectation(description: "Error handled correctly")
        
        viewModel.onError = { errorMessage in
            XCTAssertEqual(errorMessage, "Server error: Server is down")
            expectation.fulfill()
        }
        
        // When
        viewModel.fetchHouses()
        
        // Then
        wait(for: [expectation], timeout: 2.0)
    }
}


//
//  MockNetworkService.swift
//  HarryPotterTests
//
//  Created by Elif Parlak on 3.01.2025.
//

import XCTest
@testable import HarryPotter

final class MockNetworkService: NetworkServiceProtocol {
    
    var mockResponse: Data?
    var shouldReturnError = false
    var errorType: NetworkError = .serverError("Unknown error")
    
    // Fetch function for mock service
    func fetch<T: Decodable>(endpoint: HarryPotter.APIEndpoint) async throws -> T {
        if shouldReturnError {
            throw errorType
        }
        
        // In the successful case, return the mock response
        guard let mockResponse = mockResponse else {
            throw NetworkError.noData // If no mock response is set, simulate no data error
        }
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: mockResponse)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
}

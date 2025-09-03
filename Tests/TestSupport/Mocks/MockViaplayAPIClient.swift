//
//  MockViaplayAPIClient.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//


import Foundation

final class MockViaplayAPIClient: APIClient {
    let baseURL: URL
    
    var shouldThrowError: Bool = false
    var errorToThrow: Error = URLError(.badServerResponse)
    var mockResponse: ViaplayPage?
    var networkDelay: TimeInterval = 0.1
    
    init(baseURL: URL = URL(string: "https://content.viaplay.com/ios-se")!) {
        self.baseURL = baseURL
    }
    
    func fetchPage() async throws -> ViaplayPage {
        if networkDelay > 0 {
            try await Task.sleep(nanoseconds: UInt64(networkDelay * 1_000_000_000))
        }
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        if let mockResponse = mockResponse {
            return mockResponse
        }
        
        return createDefaultMockResponse()
    }
    
    func configureMockSuccess(with page: ViaplayPage) {
        shouldThrowError = false
        mockResponse = page
    }
    
    func configureMockError(_ error: Error) {
        shouldThrowError = true
        errorToThrow = error
        mockResponse = nil
    }
    
    func configureNetworkDelay(_ delay: TimeInterval) {
        networkDelay = delay
    }
    
    func reset() {
        shouldThrowError = false
        errorToThrow = URLError(.badServerResponse)
        mockResponse = nil
        networkDelay = 0.1
    }
        
    private func createDefaultMockResponse() -> ViaplayPage {
        return(
            ViaplayPage.rootMock
        )
    }
}

extension MockViaplayAPIClient {
    
    static func successMock(with page: ViaplayPage) -> MockViaplayAPIClient {
        let mock = MockViaplayAPIClient()
        mock.configureMockSuccess(with: page)
        return mock
    }
    
    static func networkErrorMock() -> MockViaplayAPIClient {
        let mock = MockViaplayAPIClient()
        mock.configureMockError(URLError(.networkConnectionLost))
        return mock
    }
    
    static func serverErrorMock() -> MockViaplayAPIClient {
        let mock = MockViaplayAPIClient()
        mock.configureMockError(URLError(.badServerResponse))
        return mock
    }
    
    static func timeoutMock() -> MockViaplayAPIClient {
        let mock = MockViaplayAPIClient()
        mock.configureNetworkDelay(30)
        mock.configureMockError(URLError(.timedOut))
        return mock
    }
}

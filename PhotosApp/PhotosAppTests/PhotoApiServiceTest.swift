//
//  PhotoApiServiceTest.swift
//  PhotosAppTests
//
//  Created by Rajeswaran Thangaperumal on 16/02/23.
//

import XCTest
@testable import PhotosApp

final class PhotoApiServiceTest: XCTestCase {

    var urlSession: URLSession!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPhotApi() throws {
            // Photos API. Injected with custom url session for mocking
    
        let photoService = PhotosListService()
            // Set mock data
            let sampleProfileData = [Photo(albumId: 1, id: 123, url: "", thumbnailUrl: "")]
            let mockData = try JSONEncoder().encode(sampleProfileData)
            
            // Return data in mock request handler
            MockURLProtocol.requestHandler = { request in
                return (HTTPURLResponse(), mockData)
            }
            
            // Set expectation. Used to test async code.
            let expectation = XCTestExpectation(description: "response")
            
            // Make mock network request to get profile
           
        
        photoService.getPhotos { (photoResponse, message) in
            XCTAssertEqual(photoResponse?.first?.id, photoResponse?.first?.albumId)
            expectation.fulfill()
        }
            wait(for: [expectation], timeout: 1)
        }

}

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
    }
}


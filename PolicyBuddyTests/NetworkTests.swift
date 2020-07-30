//
//  NetworkTests.swift
//  PolicyBuddyTests
//
//  Created by Rupali on 29/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import XCTest

@testable import PolicyBuddy

class NetworkTests: XCTestCase {
    
    func testSession() {
        let mockUrl = URL(string: "test://mockurl.com")
        let interval: TimeInterval = 5
        
        let request = URLRequest(url: mockUrl!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: interval)
        
        let session = NetworkSessionMock()
        
        session.loadData(from: request) { (data, response, err) in
            
            XCTAssertTrue(session.dataLoadCalled)
            XCTAssertEqual(mockUrl?.absoluteString, session.urlString)
        }
    }
    
}

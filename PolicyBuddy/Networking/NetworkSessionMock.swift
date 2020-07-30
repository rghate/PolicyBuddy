//
//  NetworkSessionMock.swift
//  PolicyBuddy
//
//  Created by Rupali on 29/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//
// A mock URLsession class for unit testing.

import Foundation

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    var dataLoadCalled = false
    var urlString: String?
    
    func loadData(from request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        dataLoadCalled = true
        urlString = request.url?.absoluteString

        completionHandler(data, response, error)
    }
    
}

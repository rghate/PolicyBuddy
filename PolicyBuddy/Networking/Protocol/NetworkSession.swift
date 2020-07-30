//
//  NetworkSession.swift
//  PolicyBuddy
//
//  Created by Rupali on 29/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//
// Ccustom protocol and an extension to URLSession. This is created so that a mock class(NetworkSessionMock)
// could extend the protocol for unit testing.

import Foundation

protocol NetworkSession {
    func loadData(from request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    
}

extension URLSession: NetworkSession {
    
    func loadData(from request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let task = dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
        
        task.resume()
    }
}

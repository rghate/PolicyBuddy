//
//  NetworkConfiguration.swift
//  PolicyBuddy
//
//  Created by Rupali on 23/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//
import Foundation

class NetworkConfiguration {
    let scheme: String
    let host: String
    let path: String
    let queryItems: [URLQueryItem]
    let urlComponent: URLComponents?
    
    init(scheme: String,
         host: String,
         path: String,
         queryItems: [URLQueryItem]) {
        
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems

        self.urlComponent = URLComponents(scheme: self.scheme, host: self.host, path: self.path, queryItems: queryItems)
    }
}

extension URLComponents {
    init(scheme: String,
         host: String,
         path: String,
         queryItems: [URLQueryItem]) {

        self.init()

        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems
    }
}

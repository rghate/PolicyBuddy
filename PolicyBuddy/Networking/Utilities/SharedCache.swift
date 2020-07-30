//
//  SharedCache.swift
//  PolicyBuddy
//
//  Created by Rupali on 23/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class SharedCache {
    static let shared = SharedCache()
    //MARK: Public variables


    //MARK: Initializers

    private init() {

//        let cacheSizeMegabytes = 10
//          URLCache.shared = URLCache(
//              memoryCapacity: cacheSizeMegabytes * 1024 * 1024,
//              diskCapacity: 0,
//              diskPath: nil)
    }
    
    //MARK: Public Methods
    /**
        Function to clear image  as well as URLcache
     */
    func clearAllCache() {
        // clear URL cache
        URLCache.shared.removeAllCachedResponses()
    }
}

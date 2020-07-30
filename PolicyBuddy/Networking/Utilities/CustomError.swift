//
//  CustomError.swift
//
//  Created by Rupali on 04/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import Foundation

struct CustomError: LocalizedError {
    let localizedDescription: String
    
    init(description: String) {
        localizedDescription = description
    }
}

//
//  Double.swift
//  PolicyBuddy
//
//  Created by Rupali on 27/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

extension Double {
    
    func toCurrency(localeIdentifier identifier: String = "en_GB") -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .init(identifier: identifier)
        
        return formatter.string(from: NSNumber(value: self))
    }
}

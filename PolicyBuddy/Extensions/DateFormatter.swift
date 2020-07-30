//
//  DateFormatter.swift
//  PolicyBuddy
//
//  Created by Rupali on 25/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let dateFormatterWithLongTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        return formatter
    }()
    
    static let dateFormatterWithWeekday: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy"

        return formatter
    }()
    
    static let dateFormatterWithShortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy 'at' HH:mm"
        
        return formatter
    }()
}

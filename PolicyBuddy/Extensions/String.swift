//
//  String.swift
//  PolicyBuddy
//
//  Created by Rupali on 27/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    func makePretty() -> String {
        let str = self.replacingOccurrences(of: "_", with: " ")
        return str.capitalizingFirstLetter()
    }
}

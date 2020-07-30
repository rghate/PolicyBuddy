//
//  NibView.swift
//  PolicyBuddy
//
//  Created by Rupali on 18/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit
class NibView: UIView {
    var view: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        xibSetup()
                
    }
}
private extension NibView {
    
    func xibSetup() {
          let view = loadNib()
          view.frame = bounds
          view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          addSubview(view)      
    }
}

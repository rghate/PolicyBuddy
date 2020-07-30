//
//  BaseCardCell.swift
//  PolicyBuddy
//
//  Created by Rupali on 17/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class BaseCardCell: UICollectionViewCell {
    //this method is called everytime dequeueReusableCell is called from 'cellForItemAt' method on UICollectionView
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 6
        
        // setup shadow
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true

        // to make sure iOS caches the shadow at the same drawing scale as the main screen.
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
}

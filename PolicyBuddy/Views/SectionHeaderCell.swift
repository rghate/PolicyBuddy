//
//  SectionHeaderCell.swift
//  PolicyBuddy
//
//  Created by Rupali on 20/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class SectionHeaderCell: UICollectionReusableView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.textColor = Color.SUBTITLE_COLOR
            label.font  = UIFont(name: Fonts.sfTextBold, size: 14)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

//
//  ReceiptCell.swift
//  PolicyBuddy
//
//  Created by Rupali on 23/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class ReceiptCell: BaseCardCell {
    
    // MARK: Publlic Properties
    
    var isRowContentProminant: Bool = false {
        didSet {
            if isRowContentProminant == true {
                itemLabel.font = UIFont.systemFont(ofSize: itemLabel.fontSize, weight: .bold)
                amountLabel.font = UIFont.systemFont(ofSize: amountLabel.fontSize, weight: .bold)
                itemLabel.textColor = Color.TITLE_COLOR
                amountLabel.textColor = Color.TITLE_COLOR
            } else {
                itemLabel.font = UIFont.systemFont(ofSize: itemLabel.fontSize, weight: .bold)
                amountLabel.font = UIFont.systemFont(ofSize: amountLabel.fontSize, weight: .bold)
                itemLabel.textColor = Color.SUBTITLE_COLOR
                amountLabel.textColor = Color.SUBTITLE_COLOR
            }
        }
    }
    
    @IBOutlet weak var itemLabel: UILabel! {
        didSet {
            itemLabel.font = UIFont(name: Fonts.sfTextBold, size: 14)
            itemLabel.textColor = Color.SUBTITLE_COLOR
        }
    }
    
    @IBOutlet weak var amountLabel: UILabel! {
        didSet {
            amountLabel.font = UIFont(name: Fonts.sfTextBold, size: 14)
            amountLabel.textColor = Color.SUBTITLE_COLOR
        }
    }
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    // MARK: Private Methods
    
    private func setup() {        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

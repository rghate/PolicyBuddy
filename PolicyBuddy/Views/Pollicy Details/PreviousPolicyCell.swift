//
//  PreviousPolicyCell.swift
//  PolicyBuddy
//
//  Created by Rupali on 23/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class PreviousPolicyCell: BaseCardCell {
    
    // MARK: Public Properties

    var policy: PolicyViewModel? {
        didSet {
            guard let policy = policy else { return }
            
            let endDate = policy.endDate
            let currentDate = Date()
            
            if policy.isVoided {
                durationLabel.text = "Voided"
                durationLabel.textColor = Color.ALERT_COLOR
            } else {
                durationLabel.textColor = Color.SUBTITLE_COLOR
                // compare dates before calculating interval
                let maxOffset: (value: Int, type: Date.IntervalType) =
                    (endDate > currentDate) ? endDate.maxOffsetFrom(date: currentDate) :
                        Date().maxOffsetFrom(date: endDate)
                
                durationLabel.text = "\(maxOffset.value) \(maxOffset.type)"
            }
            
            dateLabel.text = DateFormatter.dateFormatterWithWeekday.string(from: endDate)
        }
    }
    
    @IBOutlet weak var durationLabel: UILabel! {
        didSet {
            durationLabel.font = UIFont(name: Fonts.sfTextBold, size: 12)
            durationLabel.textColor = Color.SUBTITLE_COLOR
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!  {
        didSet {
            dateLabel.font = UIFont(name: Fonts.sfTextBold, size: 12)
            dateLabel.textColor = Color.SUBTITLE_COLOR
        }
    }
    
    @IBOutlet weak var arrowImageView: UIImageView! {
        didSet {
            arrowImageView.tintColor = .darkGray
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

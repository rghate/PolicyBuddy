//
//  CustomFooter.swift
//  PolicyBuddy
//
//  Custom footer class of collectionview. Contains activity indicator view and label to display
//  text message.
//
//  Created by Rupali on 23/07/2020.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class CustomFooter: UICollectionViewCell {

    //MARK: Private properties

    private let waitIndicator: UIActivityIndicatorView = {
       let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = false
        indicatorView.style = .whiteLarge
        indicatorView.color = .gray
        return indicatorView
    }()
    
    private let messageLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please wait"
        label.textColor = .lightGray
        label.font  = UIFont(name: Fonts.sfTextBold, size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    //MARK: Public methods
    /**
     Set text to message label, with activity indicator visibility flag.
     */
    func setMessage(withText text: String, visibleWaitIndicator: Bool) {
        messageLabel.text = text

        if visibleWaitIndicator {
            waitIndicator.startAnimating()
        } else {
            waitIndicator.stopAnimating()
        }
        waitIndicator.isHidden = !visibleWaitIndicator
    }

    /**
        Reset text from message label, with activity indicator visibility flag.
     */
    func resetMessage(visibleWaitIndicator: Bool) {
        messageLabel.text = ""
        
        if visibleWaitIndicator {
            waitIndicator.startAnimating()
        } else {
            waitIndicator.stopAnimating()
        }
        waitIndicator.isHidden = !visibleWaitIndicator
    }


    //MARK: Private methods

    private func setupViews() {
        addSubview(messageLabel)
        //messageLabel constraints
        
        //centered vertically
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        //left anchor from view
        messageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        //right anchor from view
        messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        

        addSubview(waitIndicator)

        //waitIndicator constraints
        
        //centered horizontally
        waitIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //top anchor below messageLabel
        waitIndicator.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

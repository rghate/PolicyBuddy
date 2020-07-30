//
//  BaseController.swift
//  PolicyBuddy
//
//  Created by Rupali on 23/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    // MARK: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.PRIMARY_BACKGROUND_COLOR
        
        customizeNavigationBar()
    }
    
    
    // MARK: Public Methods
    
    func customizeNavigationBar(backgroundColor: UIColor = Color.NAVIGATIONBAR_BACKGROUND_COLOR,
                                    tintColor: UIColor = Color.NAVIGATIONBAR_ITEM_TINT_COLOR,
                                    titleColor: UIColor = Color.NAVIGATIONBAR_ITEM_TINT_COLOR) {
        self.navigationController?.navigationBar.barTintColor = backgroundColor
        self.navigationController?.navigationBar.tintColor  = tintColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : titleColor]

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        self.navigationController?.navigationBar.isTranslucent = false
    }
}

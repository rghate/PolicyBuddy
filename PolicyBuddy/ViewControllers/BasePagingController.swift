//
//  BasePagingController.swift
//  PolicyBuddy
//
//  Created by Rupali on 23/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class BasePagingController: BaseController {
    
    // MARK: Public Methods
    
    var numberOfPages: Int = 2 {
        didSet {
            mainCollectionView.reloadData()
        }
    }
    
    lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        
        return cv
    }()
    
    
    // MARK: Private Properties
    
    private let cellId = "cellId"
    
    
    // MARK: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.isPagingEnabled = true
        mainCollectionView.showsHorizontalScrollIndicator = false
        mainCollectionView.contentInsetAdjustmentBehavior = .never
        
        if let flowLayout = mainCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
    }
}


// MARK: Extionsions

extension BasePagingController: UICollectionViewDelegateFlowLayout {
    
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.bounds.height)
    }
}


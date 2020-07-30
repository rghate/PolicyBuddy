//
//  BaseCell.swift
//  PolicyBuddy
//
//  Created by Rupali on 22/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

protocol BaseCellDelegate: class {
    func handleRefresh()
}

class BaseCell: UICollectionViewCell {
    
    // MARK: Public properties
    
    weak var navigationController: UINavigationController?
    
    weak var baseCellDelegate: BaseCellDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Color.PRIMARY_BACKGROUND_COLOR
        cv.showsVerticalScrollIndicator = false
        
        return cv
    }()
    
    var contentInset: UIEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0) {
        didSet {
            collectionView.contentInset = contentInset
        }
    }
    
    // MARK: Private properties
    
    private let lineSpacing: CGFloat = 6
    
    private let sectionInsetBottom: CGFloat = 20
    
    
    // MARK: Initializers
    
    //this method is called everytime dequeueReusableCell is called from 'cellForItemAt' method on UICollectionView
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Methods
    
    func setupViews() {
        addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.contentInsetAdjustmentBehavior = .never
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = lineSpacing
            flowLayout.sectionInset.bottom = sectionInsetBottom
        }
        collectionView.contentInset = contentInset
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Refresh control methods and handlers
    /**
     Function to setup refresh control on collectionView
     */
    func setupRefreshControl() {
        DispatchQueue.main.async {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(self.handleRefresh), for: .valueChanged)
            self.collectionView.refreshControl = refreshControl
        }
    }
    
    func endRefresh() {
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    
    // MARK: Action Handlers
    
    // Refreshcontrol handler
    
    @objc private func handleRefresh() {
        baseCellDelegate?.handleRefresh()
    }
}

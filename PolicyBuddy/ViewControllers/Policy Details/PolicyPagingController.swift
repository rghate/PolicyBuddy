//
//  PolicyPagingController.swift
//  PolicyBuddy
//
//  Created by Rupali on 22/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit
import Material

class PolicyPagingController: BasePagingController {
    
    // MARK: Public Properties
    
    var itemEntity = EntityViewModel()
    
    @IBOutlet weak var headerView: PolicyHeaderView!
    
    
    
    // MARK: Private Properties
    
    private let cellId = "cellId"
    
    private lazy var screenTitle: String = screenText?.title ?? "Vehicle profile"

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var screenText = appDelegate.applicationStrings?.strings.policyDetail


    // MARK: Initializers
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        mainCollectionView.register(PolicyDetailsController.self, forCellWithReuseIdentifier: cellId)
        mainCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
    }
    
    
    // MARK: Private Properties
    
    private func setupViews() {
        
        view.backgroundColor = Color.PRIMARY_BACKGROUND_COLOR
        
        numberOfPages = 1
        
        headerView.cellData = itemEntity
        headerView.delegate = self
        
        // collectionview
        view.addSubview(mainCollectionView)
        mainCollectionView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        
        view.bringSubviewToFront(headerView)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = screenTitle
        
        customizeNavigationBar(backgroundColor: Color.TEXT_HIGHLIGHT_COLOR, tintColor: Color.PRIMARY_BUTTON_TEXT_COLOR)
        if #available(iOS 13.0, *) {
            // Left bar button item
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: IMG_CLOSE), style: .plain, target: self, action: #selector(handleClose))
            // Right bar button item
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: IMG_QUESTION_FILLED), style: .plain, target: self, action: #selector(handleHelp))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: IMG_CLOSE), style: .plain, target: self, action: #selector(handleClose))
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: IMG_QUESTION_FILLED), style: .plain, target: self, action: #selector(handleHelp))
        }
    }

    
    // MARK: Action Handlers
    
    @objc func handleClose() {
        dismiss(animated: true)
    }
    
    @objc func handleHelp() {
        print("Get Help")
    }
}


// MARK: Extensions

extension PolicyPagingController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PolicyDetailsController
        
        cell.entityViewModel = itemEntity
        
        cell.backgroundColor = Color.PRIMARY_BACKGROUND_COLOR
        cell.navigationController = self.navigationController
        
        return cell
    }
}


extension PolicyPagingController: PolicyHeaderViewDelegate {
    
    func policyButtonPressed(sender: FlatButton) {
        print("Policy button handler")
    }
}


//
//  MainNavigationViewController.swift
//  restaurant-list
//
//  Created by Guadalupe Vlček on 27/11/2022.
//

import UIKit

class MainNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The main idea is to rely on dependency injection instead of singletons.
        let presenter = MainViewControllerPresenter(webService: .init(), coreDataHelper: .init())
        let mainViewController = MainViewController(presenter: presenter)
        presenter.view = mainViewController
        pushViewController(mainViewController, animated: false)
    }
}

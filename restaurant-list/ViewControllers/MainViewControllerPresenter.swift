//
//  MainViewControllerPresenter.swift
//  restaurant-list
//
//  Created by Guadalupe Vlček on 27/11/2022.
//

import Foundation

class MainViewControllerData {
    var restaurants: [Restaurant]
    
    init(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
}

protocol MainViewControllerProtocol: AnyObject {
    func loadRestaurants(restaurants: [Restaurant])
}

class MainViewControllerPresenter: MainViewControllerPresenterProtocol {
    weak var view: MainViewControllerProtocol?
    private let webService: WebServices

    init(webService: WebServices) {
        self.webService = webService
    }

    func fetchRestaurants() {
        webService.fetchResultsFromApi(completionHandler: { [weak self] result in
            self?.view?.loadRestaurants(restaurants: result)
        })
    }
}

extension MainViewControllerData {
    convenience init() {
        self.init(restaurants: [])
    }
}

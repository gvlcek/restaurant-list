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
    private let coreDataHelper: CoreDataHelper

    init(webService: WebServices, coreDataHelper: CoreDataHelper) {
        self.webService = webService
        self.coreDataHelper = coreDataHelper
    }

    func fetchRestaurants() {
        webService.fetchResultsFromApi(completionHandler: { [weak self] result in
            self?.view?.loadRestaurants(restaurants: result)
        })
    }
    
    func updateFavorite(uuid: String, isFavorite: Bool) {
        coreDataHelper.saveFavorite(uuid: uuid, isFavorite: isFavorite)
    }
    
    func getFavoriteStatus(uuid: String) -> Bool {
        if let status = coreDataHelper.getFavoriteStatus(uuid: uuid) {
            return status.isFavorite
        } else {
            return false
        }
    }
}

extension MainViewControllerData {
    convenience init() {
        self.init(restaurants: [])
    }
}

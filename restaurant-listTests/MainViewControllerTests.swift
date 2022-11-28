//
//  MainViewControllerTests.swift
//  restaurant-listTests
//
//  Created by Guadalupe Vlček on 28/11/2022.
//

import XCTest
@testable import restaurant_list

class MainViewControllerTests: XCTestCase {
    var subject: MainViewController!
    private var presenter: MockMainViewControllerPresenter!

    override func setUp() {
        super.setUp()

        presenter = MockMainViewControllerPresenter()
        subject = MainViewController(presenter: presenter)
        _ = subject.view
    }
    
    func test_viewDidLoadCallsFetchRestaurants() {
        XCTAssertEqual(presenter.restaurantsFetched, true)
    }
    
    func test_PresenterUpdateFavorite() {
        presenter.updateFavorite(uuid: "231231231", isFavorite: true)
        XCTAssertEqual(presenter.isUpdated, true)
    }
    
    func test_GetFavoriteStatus() {
        XCTAssertEqual(presenter.getFavoriteStatus(uuid: ""), true)
    }
}

fileprivate class MockMainViewControllerPresenter: MainViewControllerPresenterProtocol {
    var restaurantsFetched = false
    func fetchRestaurants() {
        restaurantsFetched = true
    }
    
    var isUpdated = false
    func updateFavorite(uuid: String, isFavorite: Bool) {
        isUpdated = true
    }
    
    func getFavoriteStatus(uuid: String) -> Bool {
        return true
    }
}


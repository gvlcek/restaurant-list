//
//  MainViewControllerPresenterTests.swift
//  restaurant-listTests
//
//  Created by Guadalupe Vlček on 28/11/2022.
//

import XCTest
@testable import restaurant_list

class MainViewControllerPresenterTests: XCTestCase {
    fileprivate var view: MockView!
    fileprivate var subject: MainViewControllerPresenter!

    override func setUp() {
        super.setUp()

        view = MockView()

        subject = MainViewControllerPresenter(webService: MockWebServices(), coreDataHelper: CoreDataHelper())
        subject.view = view
    }
    
    override func tearDown() {
        super.tearDown()

        view = nil
        subject = nil
    }
    
    func test_loadData() {
        subject.fetchRestaurants()
        XCTAssertEqual(view.restaurantsResult.count, 1)
    }
}

fileprivate class MockView: MainViewControllerProtocol {
    var restaurantsResult: [restaurant_list.Restaurant] = []
    func loadRestaurants(restaurants: [restaurant_list.Restaurant]) {
        restaurantsResult = restaurants
    }
}

fileprivate class MockWebServices: WebServices {
    let restaurant = Restaurant(name: "Test", uuid: "123312", servesCuisine: "arg", priceRange: 122, currenciesAccepted: "USD", address: Address(street: "yada yada", postalCode: "12123", locality: "arg", country: "arg"), mainPhoto: nil, aggregateRatings: AggregateRatings(thefork: TheforkRatings(ratingValue: 10, reviewCount: 10), tripadvisor: TripadvisorRatings(ratingValue: 10, reviewCount: 10)), bestOffer: BestOffer(name: "122", label: "offer"))
    
    override func fetchResultsFromApi(completionHandler: @escaping ([Restaurant]) -> ()) {
        completionHandler([restaurant])
    }
}

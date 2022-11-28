//
//  MainTableViewCellTests.swift
//  restaurant-listTests
//
//  Created by Guadalupe Vlček on 28/11/2022.
//

import XCTest
@testable import restaurant_list

class ImportedMapsPageTableViewCellTests: XCTestCase {
    private var delegate: MockMainTableViewCellDelegate!
    var subject: MainTableViewCell!

    override func setUp() {
        super.setUp()
        
        delegate = MockMainTableViewCellDelegate()
        subject = MainTableViewCell(style: .value1, reuseIdentifier: "")
    }

    func test_UserDidSelectFavorite() {
        let viewData = getTestViewData()
        subject.restaurant = viewData.restaurants.first
        subject.delegate = delegate
        
        subject.buttonTapped(subject as Any)
        XCTAssertEqual(delegate.isFavoriteSelected, true)
    }

    private func getTestViewData() -> MainViewControllerData {
        let restaurant = Restaurant(name: "Test", uuid: "123312", servesCuisine: "arg", priceRange: 122, currenciesAccepted: "USD", address: Address(street: "yada yada", postalCode: "12123", locality: "arg", country: "arg"), mainPhoto: nil, aggregateRatings: AggregateRatings(thefork: TheforkRatings(ratingValue: 10, reviewCount: 10), tripadvisor: TripadvisorRatings(ratingValue: 10, reviewCount: 10)), bestOffer: BestOffer(name: "122", label: "offer"))
        return MainViewControllerData(restaurants: [restaurant])
    }
}

fileprivate class MockMainTableViewCellDelegate: MainTableViewCellDelegate {
    var isFavoriteSelected = false
    func userDidSelectFavorite(uuid: String, isFavorite: Bool) {
        isFavoriteSelected = true
    }
}


//
//  Restaurant.swift
//  restaurant-list
//
//  Created by Guadalupe Vlček on 27/11/2022.
//

import Foundation

struct Restaurants: Decodable {
    let restaurants: [Restaurant]
    
    enum CodingKeys : String, CodingKey {
        case restaurants = "data"
    }
}

struct Restaurant: Decodable {
    let name: String
    let uuid: String
    let servesCuisine: String
    let priceRange: Int
    let currenciesAccepted: String
    let address: Address
    let mainPhoto: MainPhoto?
    let aggregateRatings: AggregateRatings
    let bestOffer: BestOffer
}

struct Address: Decodable {
    let street: String
    let postalCode: String
    let locality: String
    let country: String
}

struct AggregateRatings: Decodable {
    let thefork: TheforkRatings
    let tripadvisor: TripadvisorRatings
}

struct TheforkRatings: Decodable {
    let ratingValue: Double
    let reviewCount: Double
}

struct TripadvisorRatings: Decodable {
    let ratingValue: Double
    let reviewCount: Double
}

struct BestOffer: Decodable {
    let name: String
    let label: String
}

struct MainPhoto: Decodable {
    let squareImage: String?
    
    enum CodingKeys : String, CodingKey {
        case squareImage = "184x184"
    }
}

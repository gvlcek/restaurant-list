//
//  WebServices.swift
//  restaurant-list
//
//  Created by Guadalupe Vlček on 27/11/2022.
//

import Foundation

class WebServices {
    func fetchResultsFromApi(completionHandler: @escaping ([Restaurant]) -> ()) {
        guard let gitUrl = URL(string: "https://alanflament.github.io/TFTest/test.json") else { return }
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(Restaurants.self, from: data)
                completionHandler(gitData.restaurants)
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
}

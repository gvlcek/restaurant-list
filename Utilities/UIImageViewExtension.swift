//
//  UIImageViewExtension.swift
//  restaurant-list
//
//  Created by Guadalupe Vlček on 27/11/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageFromString(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
          guard let self = self else { return }
          guard let imageData = data else { return }
          DispatchQueue.main.async {
            self.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
}

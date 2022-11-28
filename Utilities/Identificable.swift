//
//  Identificable.swift
//  restaurant-list
//
//  Created by Guadalupe Vlček on 27/11/2022.
//

import UIKit

protocol Identificable {
    static var identifier: String { get }
}

extension Identificable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: Identificable {}

extension UIView: Identificable {}

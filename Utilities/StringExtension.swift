//
//  StringExtension.swift
//  restaurant-list
//
//  Created by Guadalupe Vlček on 28/11/2022.
//

import UIKit

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}

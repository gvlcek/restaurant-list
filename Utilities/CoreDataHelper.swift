//
//  CoreDataHelper.swift
//  restaurant-list
//
//  Created by Guadalupe Vlček on 28/11/2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveFavorite(uuid: String, isFavorite: Bool) {
        // First I delete the object if already exists
        deleteExistingRecord(uuid: uuid)
        
        let favoriteInstance = Favorite(context: context)
        favoriteInstance.uuid = uuid
        favoriteInstance.isFavorite = isFavorite
        do {
            try context.save()
            print("Favorite saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchFavorites() -> [Favorite] {
        var fetchingFavorite = [Favorite]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.coreDataEntity)
        
        do {
            fetchingFavorite = try context.fetch(fetchRequest) as! [Favorite]
        } catch {
            print("Error while fetching the image")
        }
        return fetchingFavorite
    }
    
    func getFavoriteStatus(uuid: String) -> Favorite? {
        let favorites = fetchFavorites()
        let result = favorites.first(where: { $0.uuid == uuid })
        return result
    }
    
    private func deleteExistingRecord(uuid: String) {
        let fetchingFavorite = fetchFavorites()
        if let deleteFetch = fetchingFavorite.first(where: { $0.uuid == uuid }) {
            context.delete(deleteFetch)
        }
    }
}

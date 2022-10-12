//
//  FavoritesInteractor.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation
import CoreData

class FavoritesInteractor {
    
    // Fetch data
    func fetchData() -> [BooksEntity] {
        let fetchRequest: NSFetchRequest<BooksEntity> = BooksEntity.fetchRequest()
        
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let sorter = NSSortDescriptor(key: #keyPath(BooksEntity.sorter), ascending: false)
            fetchRequest.sortDescriptors = [sorter]
            let result = try context.fetch(fetchRequest)
            return result
        }catch {
            print(error.localizedDescription)
            return []
        }
    }
}

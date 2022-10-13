//
//  CoreDataManager.swift
//  Books App
//
//  Created by Berkay on 13.10.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    public static var shared = CoreDataManager()
    
    // Fetch data
    func fetchAllData() -> [BooksEntity] {
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
    
    // Add data
    func addFavoriteMyBook(_ id: String, _ title: String, _ image: String) {
        
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let data = BooksEntity(context: managedContext)
        
        data.setValue(id, forKey: "id")
        data.setValue(title, forKey: #keyPath(BooksEntity.title))
        data.setValue(image, forKey: #keyPath(BooksEntity.bookImage))
        data.setValue(Date(), forKey: #keyPath(BooksEntity.sorter))
        
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
    }
    
    // Delete data
    func deleteFavoriteMyBook(_ id: String) {
        
        let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let request: NSFetchRequest<BooksEntity> = BooksEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id CONTAINS[cd] %@", id)
        
        do {
            let itemArray = try context.fetch(request)
            if !itemArray.isEmpty {
                context.delete(itemArray.first!)
            }
        }catch {
            print("Error fetching data from context, \(error)")
        }
        
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
    }
}

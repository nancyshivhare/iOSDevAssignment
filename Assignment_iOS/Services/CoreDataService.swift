//
//  CoreDataService.swift
//  Assignment_iOS
//
//  Created by apple on 10/04/25.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {

    static let shared = CoreDataService()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveItems(_ items: [ItemModel]) {
        deleteAllItems() // Clear old data before saving new

        for item in items {
            let entity = ItemEntity(context: context)
            entity.name = item.name
            
            // Safely unwrap `data` and set fields
            if let data = item.data {
                entity.color = data.color
                
                // Prefer capacity string, fallback to capacityGB
                if let capacity = data.capacity {
                    entity.capacity = capacity
                } else if let capacityGB = data.capacityGB {
                    entity.capacity = "\(capacityGB) GB"
                }
            }
        }

        do {
            try context.save()
            print("Items saved to Core Data.")
        } catch {
            print("Error saving items: \(error.localizedDescription)")
        }
    }


    func saveUser(_ user: UserModel) {
        let entity = UserEntity(context: context)
        entity.name = user.name
        entity.email = user.email
        entity.profileImageURL = user.profileImageURL

        do {
            try context.save()
            print(" User saved successfully in Core Data")
        } catch {
            print(" Failed to save user: \(error.localizedDescription)")
        }
    }

    // MARK: - Fetch
    func fetchItems() -> [ItemEntity] {
        let request: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print(" Fetch error: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Update
    func updateItem(_ entity: ItemEntity, with name: String) {
        guard !name.isEmpty else {
            print(" Validation failed: Name is empty.")
            return
        }

        entity.name = name

        do {
            try context.save()
            print(" Item updated successfully.")
        } catch {
            print("Failed to update item: \(error.localizedDescription)")
        }
    }

    // MARK: - Delete Single
    func deleteItem(_ entity: ItemEntity) {
        context.delete(entity)
        do {
            try context.save()
            print("Item deleted successfully.")
        } catch {
            print(" Failed to delete item: \(error.localizedDescription)")
        }
    }

    // MARK: - Delete All
    func deleteAllItems() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ItemEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            print(" All items deleted.")
        } catch {
            print(" Failed to delete all items: \(error.localizedDescription)")
        }
    }
}

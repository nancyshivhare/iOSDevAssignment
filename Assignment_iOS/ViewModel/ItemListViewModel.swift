//
//  ItemListViewModel.swift
//  Assignment_iOS
//
//  Created by apple on 12/04/25.
//

import Foundation
import UserNotifications

class ItemListViewModel {

    var items: [ItemEntity] = []
    var onUpdate: (() -> Void)?

    func fetchFromAPI() {
        guard let url = URL(string: "https://api.restful-api.dev/objects") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("API error: \(error)")
                return
            }

            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode([ItemModel].self, from: data)
                CoreDataService.shared.saveItems(decoded)
                self.fetchFromCoreData()
            } catch {
                print("Decode error: \(error)")
            }
        }.resume()
    }

    func fetchFromCoreData() {
        self.items = CoreDataService.shared.fetchItems()
        DispatchQueue.main.async {
            self.onUpdate?()
        }
    }

    func deleteItem(at index: Int) {
            let entity = items[index]
            CoreDataService.shared.deleteItem(entity)

            if NotificationSettings.isEnabled {
                sendNotification(for: entity)
            }

            fetchFromCoreData()
        }

    func updateItem(at index: Int, with name: String) {
        guard !name.isEmpty else { return }
        let entity = items[index]
        CoreDataService.shared.updateItem(entity, with: name)
        fetchFromCoreData()
    }
    
    private func sendNotification(for item: ItemEntity) {
           let content = UNMutableNotificationContent()
           content.title = "Item Deleted"
           content.body = "Deleted item: \(item.name ?? "Unknown") with capacity \(item.capacity ?? "N/A")"
           content.sound = .default

           let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
           UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
       }
    func getItemColorAndCapacity(for item: ItemEntity) -> (color: String?, capacity: String?) {
        // Extract color and capacity from 'data' in ItemEntity
        let color = item.color // Assuming color is a property of ItemEntity
        let capacity = item.capacity // Assuming capacity is a property of ItemEntity
        
        return (color, capacity)
    }


   }


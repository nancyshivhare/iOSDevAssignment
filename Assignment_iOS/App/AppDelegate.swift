//
//  AppDelegate.swift
//  Assignment_iOS
//
//  Created by apple on 10/04/25.
//

import UIKit
import CoreData
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            print("Notification permission: \(granted)")
        }
        application.registerForRemoteNotifications()
        AppRouter.setRootViewController()
        ThemeManager.applyTheme(ThemeManager.currentTheme)
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle
   func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
     
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Assignment_iOS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
   

    private func sendNotification(for item: ItemModel) {
        let message = [
            "to": "/topics/items",
            "notification": [
                "title": "Item Deleted",
                "body": "\(item.name) has been deleted"
            ]
        ] as [String : Any]
        
        // Send message to your backend or FCM server here
    }

}

class NotificationSettings {
    static var isEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "notifications_enabled")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "notifications_enabled")
        }
    }
}

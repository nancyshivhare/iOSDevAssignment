//
//  AppRouter.swift
//  Assignment_iOS
//
//  Created by apple 13/04/25.
//

import UIKit

class AppRouter {
    
    private static let loginStatusKey = "isLoggedIn"
    
    static func setLoggedIn(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: loginStatusKey)
        UserDefaults.standard.synchronize()
    }
    
    static func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: loginStatusKey)
    }
    
    static func setRootViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC: UIViewController
        
        if isLoggedIn() {
            print("Routing to Dashboard")
            rootVC = storyboard.instantiateViewController(withIdentifier: "DashboardVC")
        } else {
            print("Routing to Login")
            rootVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        }
        
        let nav = UINavigationController(rootViewController: rootVC)
        
        // Try SceneDelegate first
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let sceneWindow = sceneDelegate.window {
            sceneWindow.rootViewController = nav
            sceneWindow.makeKeyAndVisible()
            print("Using SceneDelegate window")
        }
        // Fallback to AppDelegate
        else if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let appWindow = appDelegate.window {
            appWindow.rootViewController = nav
            appWindow.makeKeyAndVisible()
            print("Using AppDelegate window")
        }
        else {
            print("ERROR: No available window to set rootViewController")
        }
    }
}

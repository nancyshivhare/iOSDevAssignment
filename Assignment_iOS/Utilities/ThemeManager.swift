//
//  ThemeManager.swift
//  Assignment_iOS
//
//  Created by apple on 10/04/25.
//

// ThemeManager.swift

import UIKit

enum AppTheme: String {
    case light
    case dark
}

class ThemeManager {
    
    static var currentTheme: AppTheme {
        get {
            let stored = UserDefaults.standard.string(forKey: "AppTheme") ?? AppTheme.light.rawValue
            return AppTheme(rawValue: stored) ?? .light
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "AppTheme")
            applyTheme(newValue)
        }
    }
    
    static func applyTheme(_ theme: AppTheme) {
        guard let window = UIApplication.shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else { return }

        switch theme {
        case .light:
            window.overrideUserInterfaceStyle = .light
        case .dark:
            window.overrideUserInterfaceStyle = .dark
        }
    }


    static func toggleTheme(isDark: Bool) {
        currentTheme = isDark ? .dark : .light
    }
}

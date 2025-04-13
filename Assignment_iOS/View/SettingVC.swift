//
//  SettingVC.swift
//  Assignment_iOS
//
//  Created by apple on 13/04/25.
//

import UIKit

class SettingVC: UIViewController {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lblDarkMode: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkModeSwitch.isOn = ThemeManager.currentTheme == .dark
        self.navigationController?.isNavigationBarHidden = true
        applyDynamicColors()
        syncDarkModeSwitch()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeManager.applyTheme(ThemeManager.currentTheme)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyDynamicColors()
    }
    
    
    @IBAction func btnnotification(_ sender: UISwitch) {
        NotificationSettings.isEnabled = sender.isOn
        let message = sender.isOn ? "Notifications Enabled" : "Notifications Disabled"
        showToast(message: message)
    }
    
    
    @IBAction func btndarkmode(_ sender: UISwitch) {
        ThemeManager.toggleTheme(isDark: sender.isOn)
        let message = sender.isOn ? "Dark Mode Enabled" : "Light Mode Enabled"
        showToast(message: message)
    }
    
    @IBAction func btnsignout(_ sender: Any) {
        let alert = UIAlertController(
            title: "Logout",
            message: "Are you sure you want to logout?",
            preferredStyle: .alert
        )
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            AppRouter.setLoggedIn(false)
            AppRouter.setRootViewController()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showToast(message: String, duration: Double = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.numberOfLines = 0
        
        let textSize = toastLabel.intrinsicContentSize
        let labelWidth = min(textSize.width + 40, self.view.frame.width - 40)
        let labelHeight = textSize.height + 20
        
        toastLabel.frame = CGRect(x: (self.view.frame.width - labelWidth) / 2,
                                  y: self.view.frame.height - 100,
                                  width: labelWidth,
                                  height: labelHeight)
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }) { (_) in
            toastLabel.removeFromSuperview()
        }
    }
    
    
    func applyDynamicColors() {
        view.backgroundColor = .systemBackground
        baseView.backgroundColor = .secondarySystemBackground
        lblTitle.textColor = .label
        lblNotification.textColor = .label
        lblDarkMode.textColor = .label
        backButton.tintColor = .systemBlue
    }
    
    func syncDarkModeSwitch() {
        darkModeSwitch.isOn = ThemeManager.currentTheme == .dark
    }
    
}

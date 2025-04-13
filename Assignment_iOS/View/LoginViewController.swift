//
//  LoginViewController.swift
//  Assignment_iOS
//
//  Created by apple on 10/04/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel = AuthViewModel()
    private let loader = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoader()
        self.navigationController?.isNavigationBarHidden = true
        
        viewModel.onLoginSuccess = {
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                AppRouter.setLoggedIn(true)
                print("Login successful - setting logged in true")
                AppRouter.setRootViewController()
            }
        }
        
        viewModel.onLoginFailure = { error in
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                print("Login Failed: \(error)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeManager.applyTheme(ThemeManager.currentTheme)
    }
    
    @IBAction func googleSignInTapped(_ sender: UIButton) {
        loader.startAnimating()
        viewModel.signInWithGoogle(presentingVC: self)
    }
    
    private func setupLoader() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        loader.color = .systemBlue
        view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

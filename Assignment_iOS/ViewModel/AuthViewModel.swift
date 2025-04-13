//
//  AuthViewModel.swift
//  Assignment_iOS
//
//  Created by apple on 10/04/25.
//

import Foundation
import UIKit

class AuthViewModel {

    private let authService = GoogleAuthService()
    private let coreDataService = CoreDataService()

    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?

    func signInWithGoogle(presentingVC: UIViewController) {
        authService.signInWithGoogle(presentingVC: presentingVC) { [weak self] result in
            switch result {
            case .success(let userModel):
                CoreDataService.shared.saveUser(userModel)
                self?.onLoginSuccess?()
            case .failure(let error):
                self?.onLoginFailure?(error.localizedDescription)
            }
        }
    }

}

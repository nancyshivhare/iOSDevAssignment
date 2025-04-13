//
//  GoogleAuthService.swift
//  Assignment_iOS
//
//  Created by apple on 10/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class GoogleAuthService {
    
    func signInWithGoogle(presentingVC: UIViewController, completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(NSError(domain: "GoogleAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "493249956386-7514nb8tmg1l3tpjs6shigmhov8l0opp.apps.googleusercontent.com"])))
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                return
            }

            let accessToken = user.accessToken.tokenString

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let user = authResult?.user {
                    let userModel = UserModel(name: user.displayName ?? "",
                                              email: user.email ?? "",
                                              profileImageURL: user.photoURL?.absoluteString ?? "")
                    completion(.success(userModel))
                }
            }
        }


    }
}

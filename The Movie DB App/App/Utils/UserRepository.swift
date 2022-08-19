//
//  UserRepository.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import Foundation
import FirebaseAuth

class UserRepository {
    
    func validateCurrentUser() -> Bool {
        if let _ = UserDefaults.standard.string(forKey: Constants.UserDefaultKey.token){
            return true
        }else{
            return false
        }
    }
    
    func deleteCurrentUserFirebase() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
    
    func deleteToken(){
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey:Constants.UserDefaultKey.token)
    }
    
}

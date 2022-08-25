//
//  UserRepository.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import Foundation
import FirebaseAuth

class UserRepository {
    /**This class is for review te current seccion **/
    
    //MARK: - Validate current User
    
    func isActiveSession() -> Bool {
        if validateCurrentUserOnFirebase() && validateCurrentUserOnMovieDB() {
            return true
        }else{
            return false
        }
    }
    
    //MARK: - Validate user in Moviedb
    
    func validateCurrentUserOnMovieDB() -> Bool {
        if let _ = UserDefaults.standard.string(forKey: Constants.UserDefaultKey.token){
            return true
        }else{
            return false
        }
    }
    
    //MARK: - validate user on firebase
    
    func validateCurrentUserOnFirebase() -> Bool {
        if Auth.auth().currentUser != nil {
          return true
        } else {
          return false
        }
    }
    
    //MARK: -  Delete seccions
    func logOut() {
        self.deleteCurrentUserFirebase()
        self.deleteNameUser()
        self.deleteUserToken()
    }
    
    //MARK: - delete current session on firebase
    func deleteCurrentUserFirebase() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
    
    //MARK: -  delete userDefault values
    
    func deleteUserToken() {
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey:Constants.UserDefaultKey.token)
    }
    
    func deleteNameUser() {
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey: Constants.UserDefaultKey.nameUser)
    }
    
}

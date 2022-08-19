//
//  ValidationsData.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import Foundation

class ValidationsData {
    //MARK: - Properties
    
    private var nameValidate : Bool = false
    private var emailValidate: Bool = false
    private var passwordValidate: Bool = false
    private var samePassword: Bool = false
    
    //MARK: - Validation UserName
    
    func validateNameCount(with name: String) ->  Bool{
        if name.count < 3{
            nameValidate = false
        }else {
            nameValidate = true
        }
        return nameValidate
    }
    
    func validateCharacterName(name: String) -> Bool{
        let decimalCharters = CharacterSet.decimalDigits
        let decimalRange = name.rangeOfCharacter(from: decimalCharters)
        
        if decimalRange != nil{
            nameValidate = false
        }else{
            nameValidate = true
        }
        return nameValidate
    }
    
    //MARK: - Validation email
    
    func validationEmail(with email: String) -> Bool{
        let regularExpresion = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
        if !predicate.evaluate(with: email){
            emailValidate = false
        }else{
            emailValidate = true
        }
        return emailValidate
    }
    
    //MARK: - Validate Password
    
    func validatePasswordCount(with password: String) -> Bool{
        if password.count < 6 {
            passwordValidate = false
        }else {
            passwordValidate = true
        }
        return passwordValidate
    }
    
    func validatePassword(with password: String) -> Bool{
        if withDigit(value: password) && withLowerCase(value: password) && withUpperCase(value: password){
            passwordValidate = true
        }else{
            passwordValidate = false
        }
        return passwordValidate
    }
    
    private func withDigit(value: String) -> Bool{
        let regularExpresion = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
        return predicate.evaluate(with: value)
    }
    
    private func withLowerCase(value: String) -> Bool {
        let regularExpresion = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
        return predicate.evaluate(with: value)
    }
    
    private func withUpperCase(value: String) -> Bool{
        let regularExpresion = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
        return predicate.evaluate(with: value)
    }
    
    //MARK: - Confirmation Password
    /**This funtion will be just used on sign up for that reason we dont need an alert, we just need a label on view **/
    func confirmatePasswords(passwordA: String, passwordB: String) -> Bool{
        if passwordA == passwordB{
            samePassword = true
        }else{
            samePassword = false
        }
        return samePassword
    }
}

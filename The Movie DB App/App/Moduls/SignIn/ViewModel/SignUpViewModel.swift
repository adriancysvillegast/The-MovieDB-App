//
//  SignUpViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import Foundation
import FirebaseAuth

protocol SignupViewModelDelegate: AnyObject {
    func showButtton()
    func hideButton()
    func showLabel()
    func showErrorLabel(text: String)
    func hideLabel()
    func goToHome()
}

class SignUpViewModel {
    //MARK: - properties
    
    let validateData = ValidationsData()
    var service: SignUpServiceFetching?
    weak var delegate: SignupViewModelDelegate?
    weak var delegateError: ShowErrorDelegate?
    weak var delegateSpinner: SpinnerLoadDelegate?
    
    private var usernameValidation: Bool = false
    private var emailValidation: Bool = false
    private var passwordValidation: Bool = false
    private var samePasswordValidation: Bool = false
    
    //MARK: - Init
    
    init(service: SignUpServiceFetching = SignUpService()) {
        self.service = service
    }
    
    //MARK: - Register
    func register(email: String, password: String, user: String){
        self.delegateSpinner?.showSpinner()
        service?.get(onComplete: { token in
            let userDefault = UserDefaults.standard
            userDefault.set(token.guestSessionId, forKey: Constants.UserDefaultKey.token)
            self.createAcount(email: email, password: password)
            self.delegateSpinner?.hideSpinner()
        }, onError: { error in
            self.delegateSpinner?.hideSpinner()
            self.delegate?.showErrorLabel(text: error)
        })
        
        
    }
    
    //MARK: - LookData
    
    private func lookData(){
        if usernameValidation && emailValidation && passwordValidation && samePasswordValidation {
            self.delegate?.showButtton()
        }else{
            self.delegate?.hideButton()
        }
    }

    //MARK: - Validate
    func validateName(name: String?){
        guard let name = name else {
            return
        }
        
        if !validateData.validateNameCount(with: name){
            usernameValidation = false
            self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ValidationMessages.nameShort)
        }else{
            if !validateData.validateCharacterName(name: name){
                usernameValidation = false
                self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ValidationMessages.nameWithNumbers)
            }else{
                usernameValidation = true
            }
        }
        lookData()
    }
    
    func validateEmail(email: String?){
        guard let email = email else {
            return
        }
        
        if !validateData.validationEmail(with: email){
            emailValidation = false
            self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ValidationMessages.emailError)
        }else{
            emailValidation = true
        }
        lookData()
    }
    
    func validatePassword(password: String?){
        guard let password = password else {
            return
        }

        if !validateData.validatePasswordCount(with: password){
            passwordValidation = false
            self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ValidationMessages.passwordError)
        }else{
            if !validateData.validatePassword(with: password){
                passwordValidation = false
                self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ValidationMessages.passwordError)
            }else{
                passwordValidation = true
            }
        }
        lookData()
    }
    
    func confirmationPassword(passwordA: String?, passwordB: String?){
        guard let passwordA = passwordA, let passwordB = passwordB else {
            return
        }
        
        if !validateData.confirmatePasswords(passwordA: passwordA, passwordB: passwordB){
            samePasswordValidation = false
            self.delegate?.showLabel()
        }else{
            samePasswordValidation = true
            self.delegate?.hideLabel()
        }
        lookData()
    }

    
    //MARK: - Firebase
    
    func createAcount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let e = error{
                self.delegate?.showErrorLabel(text: e.localizedDescription)
            }else{
                self.delegate?.goToHome()
            }
        }
    }
    
}

//
//  LogInViewModel.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import Foundation
import FirebaseAuth

protocol LogInViewModelDelegate: AnyObject {
    func showLabel(text: String)
    func hideLabel(text: String)
    func goToHome()
    func activateButton()
    func desactivateButton()
    
}

class LogInViewModel {
    //MARK: - Properties

    let validationData = ValidationsData()
    weak var delegate: LogInViewModelDelegate?
    weak var delegateSpinner: SpinnerLoadDelegate?
    weak var delegateError: ShowErrorDelegate?
    var service: LogInServiceFetching?
    private var emailValidation: Bool = false
    private var passwordValidation: Bool = false
    
    init(service: LogInServiceFetching = LogInService()) {
        self.service = service
    }
    
    //MARK: - LogIn
    
    func logIn(email: String, password: String){
        self.delegateSpinner?.showSpinner()
        service?.get(onComplete: { token in
            let userDefault = UserDefaults.standard
            userDefault.set(token.guestSessionId, forKey: Constants.UserDefaultKey.token)
            //firebase
            self.firebaseLogIn(email: email, password: password)
            self.delegateSpinner?.hideSpinner()
        }, onError: { error in
            self.delegateSpinner?.hideSpinner()
            self.delegate?.showLabel(text: error)
        })
    }
    
    //MARK: - Button Activate
    
    func buttonActivate(){
        if emailValidation && passwordValidation{
            self.delegate?.activateButton()
        }else {
            self.delegate?.desactivateButton()
        }
    }
    
    
    //MARK: - Validations
    
    func validateEmail(with email: String?){
        guard let email = email else {
            return
        }
        
        if !validationData.validationEmail(with: email){
            emailValidation = false
            self.delegateError?.showError(title: Constants.errorTitle, message: Constants.ValidationMessages.emailError)
        }else{
            emailValidation = true
        }
        buttonActivate()
    }
    
    func validatePassword(with password: String?){
        guard let password = password else {
            return
        }
        
        if validationData.validatePassword(with: password){
            if validationData.validatePasswordCount(with: password){
                passwordValidation = true
            }else{
                passwordValidation = false
            }
        }else{
            passwordValidation = false
        }
        buttonActivate()
    }
    
//MARK: - Firebase
    
    func firebaseLogIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let e = error{
                self.delegateError?.showError(title: Constants.errorTitle, message: e.localizedDescription)
            }else{
                self.delegate?.goToHome()
            }
        }
    }
    
}



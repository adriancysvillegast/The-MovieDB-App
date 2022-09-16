//
//  SignUpViewController.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import UIKit


class SignUpViewController: UIViewController {
    //MARK: - Properties
    
    lazy var contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height + 50)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        scrollView.contentSize = contentSize
        scrollView.frame = self.view.bounds
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.bounces = true
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let aView = UIView()
        aView.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        aView.frame.size = contentSize
        return aView
    }()
    
    private lazy var viewModel: SignUpViewModel = {
        let viewModel = SignUpViewModel()
        viewModel.delegate = self
        viewModel.delegateError = self
        viewModel.delegateSpinner = self
        return viewModel
    }()
    
    private lazy var logo: UIImageView = {
        let aView = UIImageView()
        aView.contentMode = .scaleAspectFit
        aView.image = UIImage(named: "imageLogo")
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    //    TextFields
    private lazy var usernameTextField:  UITextField = {
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        let text = UITextField()
        text.leftView = spacer
        text.leftViewMode = .always
        text.layer.borderColor = UIColor.white.cgColor
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 0.5
        text.textContentType = .username
        text.attributedPlaceholder = NSAttributedString(
            string: "add your name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        text.delegate = self
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var emailTextField:  UITextField = {
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        let text = UITextField()
        text.leftView = spacer
        text.leftViewMode = .always
        text.layer.borderColor = UIColor.white.cgColor
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 0.5
        text.textContentType = .emailAddress
        text.attributedPlaceholder = NSAttributedString(
            string: "Add your email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        text.delegate = self
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var passwordTextField:  UITextField = {
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        let text = UITextField()
        text.leftView = spacer
        text.leftViewMode = .always
        text.layer.borderColor = UIColor.white.cgColor
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 0.5
        text.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        text.delegate = self
        text.textColor = .white
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var passwordConfTextField:  UITextField = {
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        let text = UITextField()
        text.leftView = spacer
        text.leftViewMode = .always
        text.layer.borderColor = UIColor.white.cgColor
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 0.5
        text.isSecureTextEntry = true
        text.attributedPlaceholder = NSAttributedString(
            string: "Add your password again",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        text.delegate = self
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    //    Bottons
    private var buttonRegister: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemGreen
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.isEnabled = false
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //Label to error password
    private let errorPasswordLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "This password is not the same!"
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.color = .white
        spinner.isHidden = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        setupView()
        setupConstraints()
        addTargets()
    }
    
    //MARK: - SetupView
    private func setupView(){
        view.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        [ logo, usernameTextField, emailTextField, passwordTextField, passwordConfTextField,errorPasswordLabel, buttonRegister].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 10),
            logo.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 250),
            logo.heightAnchor.constraint(equalToConstant: 140),
            
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            usernameTextField.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -5),
            usernameTextField.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            usernameTextField.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -5),
            emailTextField.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            emailTextField.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordConfTextField.topAnchor, constant: -5),
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            
            passwordConfTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordConfTextField.bottomAnchor.constraint(equalTo: buttonRegister.topAnchor, constant: -25),
            passwordConfTextField.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            passwordConfTextField.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            
            errorPasswordLabel.topAnchor.constraint(equalTo: passwordConfTextField.bottomAnchor, constant: 5),
            errorPasswordLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            buttonRegister.bottomAnchor.constraint(equalTo: containerView.keyboardLayoutGuide.topAnchor, constant: -10),
            buttonRegister.heightAnchor.constraint(equalToConstant: 50),
            buttonRegister.widthAnchor.constraint(equalToConstant: 180),
            buttonRegister.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    //MARK: - add targets
    
    private func addTargets(){
        usernameTextField.addTarget(self, action: #selector(self.validateName), for: UIControl.Event.editingDidEnd)
        
        emailTextField.addTarget(self, action: #selector(self.validateEmail), for: UIControl.Event.editingDidEnd)
        
        passwordTextField.addTarget(self, action: #selector(self.validatePassword), for: UIControl.Event.editingDidEnd)
        
        passwordConfTextField.addTarget(self, action: #selector(self.confirmationPassword), for: UIControl.Event.editingChanged)
        
        buttonRegister.addTarget(self, action: #selector(self.registerUser), for: .touchUpInside)
    }
    
    @objc func validateName(){
        viewModel.validateName(name: usernameTextField.text)
    }
    
    @objc func validateEmail(){
        viewModel.validateEmail(email: emailTextField.text)
    }
    
    @objc func validatePassword(){
        viewModel.validatePassword(password: passwordTextField.text)
    }
    
    @objc func confirmationPassword(){
        viewModel.confirmationPassword(passwordA: passwordTextField.text, passwordB: passwordConfTextField.text)
    }
    
    @objc func registerUser(){
        self.viewModel.register(email: emailTextField.text!, password: passwordTextField.text!, user: usernameTextField.text!)
    }
}

//MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - SignUpViewModel

extension SignUpViewController: SignupViewModelDelegate {
    func showErrorLabel(text: String) {
        errorPasswordLabel.text = text
        errorPasswordLabel.isHidden = false
    }
    
    func showButtton() {
        buttonRegister.isEnabled = true
        buttonRegister.backgroundColor = .green
    }
    
    func hideButton() {
        buttonRegister.isEnabled = false
        buttonRegister.backgroundColor = .gray
    }
    
    func showLabel() {
        errorPasswordLabel.text = Constants.LabelMessage.label
        errorPasswordLabel.isHidden = false
    }
    
    func hideLabel() {
        errorPasswordLabel.isHidden = true
    }
    
    func goToHome() {
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
//MARK: - ShowErrorDelegate

extension SignUpViewController: ShowErrorDelegate  {
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}

//MARK: - SpinnerLoadDelegate

extension SignUpViewController: SpinnerLoadDelegate {
    func showSpinner() {
        DispatchQueue.main.async {
            self.spinner.isHidden = false
            self.spinner.startAnimating()
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
        }
    }
    
}

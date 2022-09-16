//
//  LogInViewController.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import UIKit

class LogInViewController: UIViewController {
    
    //MARK: - properties

    lazy var contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
    
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
    
    private lazy var viewModel: LogInViewModel = {
        let viewModel = LogInViewModel()
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
    
    private lazy var emailTextField:  UITextField = {
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        let text = UITextField()
        text.leftView = spacer
        text.leftViewMode = .always
        text.layer.borderColor = UIColor.white.cgColor
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 0.5
        text.textContentType = .newPassword
        text.attributedPlaceholder = NSAttributedString(
            string: "Email",
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
        text.isSecureTextEntry = true
        text.textContentType = .newPassword
        text.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        text.delegate = self
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private var labelAlert: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .red
        label.numberOfLines = 3
        label.isHidden = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var buttonLogIn: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemGreen
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.isEnabled = false
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var buttonCreateAccount: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 280, height: 30))
        button.setTitle("You do not have an account? Sign Up", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.color = .white
        spinner.isHidden = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    //MARK: - lifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        addTargets()
    }
    
    //MARK: - setupView
    
    private func setupView() {
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        [logo ,emailTextField, passwordTextField, labelAlert, buttonLogIn, buttonCreateAccount].forEach {
            containerView.addSubview($0)
        }
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 10),
            logo.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 250),
            logo.heightAnchor.constraint(equalToConstant: 140),
            
            emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.widthAnchor.constraint(equalToConstant: 320),
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            
            passwordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.widthAnchor.constraint(equalToConstant: 320),
            passwordTextField.bottomAnchor.constraint(equalTo: buttonLogIn.topAnchor, constant: -45),
            
                        
            buttonLogIn.heightAnchor.constraint(equalToConstant: 50),
            buttonLogIn.widthAnchor.constraint(equalToConstant: 160),
            buttonLogIn.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonLogIn.bottomAnchor.constraint(equalTo: buttonCreateAccount.topAnchor, constant: -10),
            
            labelAlert.bottomAnchor.constraint(equalTo: buttonLogIn.topAnchor, constant: 5),
            labelAlert.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            labelAlert.widthAnchor.constraint(equalToConstant: 280),
            labelAlert.heightAnchor.constraint(equalToConstant: 40),
            
            buttonCreateAccount.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonCreateAccount.bottomAnchor.constraint(equalTo: containerView.keyboardLayoutGuide.topAnchor, constant: -10)
        ])
    }
    
    //MARK: - add targets

    func addTargets(){
        buttonLogIn.addTarget(self, action: #selector(logInButton), for: .touchUpInside)
        
        emailTextField.addTarget(self, action: #selector(validateEmail), for: .editingDidEnd)
        
        passwordTextField.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
        
        buttonCreateAccount.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
    }
    
    @objc func logInButton(){
        viewModel.logIn(email: emailTextField.text!, password: passwordTextField.text!)
    }
     
    @objc func validateEmail(){
        viewModel.validateEmail(with: emailTextField.text)
    }
    
    @objc func validatePassword(){
        viewModel.validatePassword(with: passwordTextField.text)
    }
    
    @objc func goToSignUp(){
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - LogInViewModelDelegate

extension LogInViewController: LogInViewModelDelegate {
    func activateButton() {
        buttonLogIn.isEnabled = true
        buttonLogIn.backgroundColor = .systemGreen
    }
    
    func desactivateButton() {
        buttonLogIn.isEnabled = false
        buttonLogIn.backgroundColor = .systemGray
    }
    
    func goToHome() {
        DispatchQueue.main.async {
            let nextVC = HomeViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func hideLabel(text: String) {
        self.labelAlert.isHidden = true
    }
    
    func showLabel(text: String) {
        self.labelAlert.isHidden = false
        self.labelAlert.text = text
    }
    
}

//MARK: - ShowErrorDelegate

extension LogInViewController: ShowErrorDelegate {
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}

//MARK: - SpinnerLoadDelegate

extension LogInViewController: SpinnerLoadDelegate {
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


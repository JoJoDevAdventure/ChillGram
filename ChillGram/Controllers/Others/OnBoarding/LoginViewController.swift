//
//  LoginViewController.swift
//  ChillGram
//
//  Created by Youssef Bhl on 26/11/2021.
//

import UIKit
import FirebaseAuth
import SafariServices

class LoginViewController: UIViewController {

    //MARK: outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var LogInButton: UIButton!
    
    //MARK: Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        setupTextFieldManager()
        dismiss(animated: true)
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        guard let emailUsername = emailTextField.text, !emailUsername.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 8 else {
                  return
              }
        //login fonctionality
        var username : String?
        var email : String?
        if emailUsername.contains("@"), emailUsername.contains(".") {
            //email
            email = emailUsername
        } else {
            //Username
            username = emailUsername
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            if success {

                //user logged in
                self.dismiss(animated: true, completion: nil)
                }
                else {
                    // error
                    let alert = UIAlertController(title: "LogIn error.", message: "we are unable to Log you into your account.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    
    @IBAction func didTapTermsButton(_ sender: Any) {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @IBAction func didTapPrivacyButton(_ sender: Any) {
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    //MARK: private functions
    
    @objc func hideKeyBoard () {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    private func setupTextFieldManager (){
        emailTextField.delegate = self
        passwordTextField.delegate = self
    
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tapGesture)
    }
    
    //function for UI Text Fields
    private func UISetup(){
        
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderColor = .init(red: 132/255, green: 132/255, blue: 132/255, alpha: 1)
        emailTextField.backgroundColor = .secondarySystemBackground
        
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderColor = .init(red: 132/255, green: 132/255, blue: 132/255, alpha: 1)
        passwordTextField.backgroundColor = .secondarySystemBackground
        
        LogInButton.layer.cornerRadius = 10
    }
}

//MARK: Extensions

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


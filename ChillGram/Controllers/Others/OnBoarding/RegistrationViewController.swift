//
//  RegistrationViewController.swift
//  ChillGram
//
//  Created by Youssef Bhl on 26/11/2021.
//

import UIKit
import FirebaseAuth
import SafariServices

class RegistrationViewController: UIViewController {

    //MARK: outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var registredLabel: UILabel!
    
    //MARK: actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        setupTextFieldManager()
        registredLabel.isHidden = true
    }
    
    @IBAction func didTapSignUpButton(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text,!password.isEmpty, password.count >= 8,
              let username = usernameTextField.text, !username.isEmpty else {
                  return
              }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registred in
            if registred {
                self.dismiss(animated: true, completion: nil)
                    }
            else {
                //problem
            }
        }
    }

    //return to login view
    
    @IBAction func dismissRegister(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }
    
    //opens terms safari tab
    
    @IBAction func didTapTermsButton(_ sender: Any) {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    //opens Privacy safari tab
    
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
        usernameTextField.resignFirstResponder()
    }
    
    private func setupTextFieldManager (){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
    
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func UISetup(){
        
        usernameTextField.layer.masksToBounds = true
        usernameTextField.layer.borderWidth = 2
        usernameTextField.layer.cornerRadius = 10
        usernameTextField.layer.borderColor = .init(red: 132/255, green: 132/255, blue: 132/255, alpha: 1)
        usernameTextField.backgroundColor = .secondarySystemBackground
        
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
        
        SignUpButton.layer.cornerRadius = 10
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

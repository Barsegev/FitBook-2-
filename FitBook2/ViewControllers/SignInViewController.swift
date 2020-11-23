//
//  SignInViewController.swift
//  FitBook2
//
//  Created by BAR SEGEV on 5/25/20.
//  Copyright © 2020 BAR SEGEV. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes:  [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
    let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerEmail.backgroundColor = UIColor(red: 50/255, green: 50/255,
        blue: 25/255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayerEmail)
    
        
        passwordTextField.backgroundColor = UIColor.clear
            passwordTextField.tintColor = UIColor.white
            passwordTextField.textColor = UIColor.white
            passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes:  [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayerPassword = CALayer()
            bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
            bottomLayerPassword.backgroundColor = UIColor(red: 50/255, green: 50/255,
            blue: 25/255, alpha: 1).cgColor
            passwordTextField.layer.addSublayer(bottomLayerPassword)
        signinButton.isEnabled = false
            handleTextField()
   }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    
    
    //should keep user sigh in and open home view controller automticly 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "signInToTabbarVC", sender: nil)
        }
    }
    
    @IBAction func dismiss_onClick(_ sender: Any) {
               dismiss(animated: true, completion: nil)
           }
    
    
    
    func handleTextField() {
   
    emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    
        }
    @objc func textFieldDidChange() {
               guard let email = emailTextField.text, !email.isEmpty,
                   let password = passwordTextField.text, !password.isEmpty else {
                   signinButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
                   signinButton.isEnabled = true
                    
                       return
                       
               }
               signinButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
               signinButton.isEnabled = true
       }
    
    @IBAction func signInButton_TouchUpInside(_ sender: Any) {
        view.endEditing(true)
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user, error)
                    in if error != nil{
                        print(error!.localizedDescription)
                        return
                    }
                    self.performSegue(withIdentifier: "signInToTabbarVC", sender: nil)
                } )
                
                
                
                
            }
            
            

        }

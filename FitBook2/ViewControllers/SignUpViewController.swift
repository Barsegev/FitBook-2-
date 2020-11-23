//
//  SignUpViewController.swift
//  FitBook2
//
//  Created by BAR SEGEV on 5/25/20.
//  Copyright © 2020 BAR SEGEV. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseStorage


class SignUpViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   @IBOutlet weak var profileImage: UIImageView!
    var selectedImage: UIImage?
    // tryuing disply the image
    var image: UIImage? = nil
    
    
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        userNameTextField.backgroundColor = UIColor.clear
            userNameTextField.tintColor = UIColor.white
            userNameTextField.textColor = UIColor.white
            userNameTextField.attributedPlaceholder = NSAttributedString(string: userNameTextField.placeholder!, attributes:  [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayerUserName = CALayer()
            bottomLayerUserName.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
            bottomLayerUserName.backgroundColor = UIColor(red: 50/255, green: 50/255,
            blue: 25/255, alpha: 1).cgColor
            userNameTextField.layer.addSublayer(bottomLayerUserName)
    
            passwordTextField.backgroundColor = UIColor.clear
                passwordTextField.tintColor = UIColor.white
                passwordTextField.textColor = UIColor.white
                passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes:  [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
            let bottomLayerPassword = CALayer()
                bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
                bottomLayerPassword.backgroundColor = UIColor(red: 50/255, green: 50/255,
                blue: 25/255, alpha: 1).cgColor
                passwordTextField.layer.addSublayer(bottomLayerPassword)
                
            emailTextField.backgroundColor = UIColor.clear
                emailTextField.tintColor = UIColor.white
                emailTextField.textColor = UIColor.white
                emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes:  [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
            let bottomLayerEmail = CALayer()
                bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
                bottomLayerEmail.backgroundColor = UIColor(red: 50/255, green: 50/255,
                blue: 25/255, alpha: 1).cgColor
                emailTextField.layer.addSublayer(bottomLayerEmail)
                
        profileImage.layer.cornerRadius = 30
        profileImage.clipsToBounds = true
        
        
        //cheak the selecter 
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectProfileImageView))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = false
        signUpButton.isEnabled = true

        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
  func handleTextField(){

    func handleTextField() {
        userNameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        userNameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        userNameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)


        }}
      @objc func textFieldDidChange() {
            guard let username = userNameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty,
                let password = passwordTextField.text, !password.isEmpty else {
                signUpButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
                signUpButton.isEnabled = true
                    return
                    
            }
            signUpButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            signUpButton.isEnabled = true
    }
        @objc func handleSelectProfileImageView() {
        let pickerController = UIImagePickerController()
            pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        }
        @IBAction func dismiss_onClick(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        }
    
        @IBAction func signUpBtn_TouchUpInside(_ sender: Any) {
            view.endEditing(true)
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { dataresulte , error in
            if error != nil{
              print(error!.localizedDescription)
                
        self.performSegue(withIdentifier: "signUpToTabbarVC", sender: nil)

                //triyung new tranfer data

       }
                if let authData = dataresulte {
                    let dict: Dictionary<String, Any> = [
                        "uid": authData.user.uid,
                        "email": self.emailTextField.text!,
                        "profileImageUrl": "",
                        "stustes": "welcome to bar"
                    ]
                    Database.database().reference().child("Users").child(authData.user.uid).setValue(dict) { (erorr, db) in
                    }
                }
                let uid = Auth.auth().currentUser!.uid
                let storageRef = Storage.storage().reference(forURL: "gs://fitbook2-9511e.appspot.com").child("profile_image").child(uid)
                if let profileImg = self.selectedImage, let imageData = profileImg.jpegData(compressionQuality: 0.1) { storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                        if error != nil
                        {
                            return
                    }
                   let profileImageUrl = metadata?.storageReference
                                    let ref = Database.database().reference()
                                    let usersReference  = ref.child("Users")
                                    let newUserReference = usersReference.child(uid)
                                     newUserReference.setValue(["username" :self.userNameTextField.text!, "email" :self.emailTextField.text!, "ProfileImageUrl":profileImageUrl!])

                    //move the sigh UP click to next view controller 
                    self.performSegue(withIdentifier: "signUpToTabbarVC", sender: nil)

                         })
                        }}
                )}
                }


                //clices profil picture
                extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
                    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
                        print("did finish lunch")
                        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
                        selectedImage = image
                      profileImage.image = image
                            //


                        }
                        dismiss(animated: true, completion: nil)
                        dismiss_onClick(true)
                    }
                    
                }
                    


func uploadImagePic(image: UIImage, name: String, filePath: String) {
    guard let _: Data = image.jpegData(compressionQuality: 0.1) else {
        return
    }
    
}
                
                
                
                
                
                
                
                
                
                
                
 

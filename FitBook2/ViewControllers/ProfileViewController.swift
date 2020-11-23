//
//  ProfileViewController.swift
//  FitBook2
//
//  Created by BAR SEGEV on 5/25/20.
//  Copyright © 2020 BAR SEGEV. All rights reserved.
//

import UIKit
import AVKit



    class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var videoPlayer:AVPlayer?
        var videoPlayerLayer:AVPlayerLayer?
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var BMI: UIImageView!
        @IBOutlet weak var HeartRate: UIImageView!
        
        @IBOutlet weak var Friends: UIImageView!
        let imagePicker = UIImagePickerController()
           override func viewDidLoad() {
               super.viewDidLoad()
            Friends.image = UIImage(named: "friends.jpeg")
            HeartRate.image = UIImage(named: "hr.jpeg")
            BMI.image = UIImage(named: "bmi.jpeg")


            imagePicker.delegate = self

           }
        
        
  
        @IBAction func loadImageButtonTapped(_ sender: Any) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
                
            present(imagePicker, animated: true, completion: nil)
        }
        // MARK: - UIImagePickerControllerDelegate Methods

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageView.contentMode = .scaleAspectFit
                imageView.image = pickedImage
            }

            dismiss(animated: true, completion: nil)
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
       }


extension UIImageView {

func makeRounded() {
    let radius = self.frame.width/2.0
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = true
   }
    
}



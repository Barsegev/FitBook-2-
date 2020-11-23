//
//  CamraViewController.swift
//  FitBook2
//
//  Created by BAR SEGEV on 5/25/20.
//  Copyright © 2020 BAR SEGEV. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import ImagePicker

class CamraViewController: UIViewController, ImagePickerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var removeButton: UIBarButtonItem!
    var selectedImage: UIImage?
    var video: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true

    }
    func handlePost() {
        if selectedImage != nil{
            self.shareButton.isEnabled = true
            self.removeButton.isEnabled = true
            self.shareButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            self.shareButton.isEnabled = false
            self.removeButton.isEnabled = false
            self.shareButton.backgroundColor = .lightGray
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    
    }
    
    
    @IBAction func cameraButton_TouchUpInside(_ sender: Any) {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 5
        present(imagePickerController, animated: true, completion: nil)
    }
    func wrapperDidPress(_ ImagePicker: ImagePickerController, images : [UIImage]) {
        print("wrapper")
    }
    func doneButtonDidPress(_ ImagePicker: ImagePickerController, images: [UIImage]){
        print("done")
    }
    func cancelButtonDidPress(_ ImagePicker: ImagePickerController) {
        print("cancel")
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
            pickerController.delegate = self
        pickerController.mediaTypes = ["pablic.image", "public.movie"]
        present(pickerController, animated: true, completion: nil)
        
    }
    @IBAction func shareButton_TouchUpInside(_ sender: Any) {
        view.endEditing(true)
        if let profileImg = self.selectedImage, let imageData = profileImg.jpegData(compressionQuality: 0.1) {
            let photoIdString = NSUUID().uuidString
            print(photoIdString)
          let storageRef = Storage.storage().reference(forURL: Config.SRORAGE_ROOF_REF).child("posts").child(photoIdString)
            storageRef.putData(imageData, metadata: nil, completion: {(metadata, error)in if error != nil {
                return
                }
                
//               let photoUrl = metadata?.downloadURL()?.absoluteString
//                
//              self.sendDataToDatabase(photoUrl: photoUrl!)
                })

        }
                
        func sendDataToDatabase(photoUrl: String) {
            let ref = Database.database().reference()
            let postsRefrence = ref.child("posts")
            let newPostId = postsRefrence.childByAutoId().key
            let newPostRefrence = postsRefrence.child(newPostId!)
            newPostRefrence.setValue(["photoUrl": photoUrl, "caption": captionTextView.text!], withCompletionBlock: {
                (error, ref) in
                if error != nil {
                    return
                }
//                self.clean()
                self.tabBarController?.selectedIndex = 0
        })
        
    }
}
//    //the file needs to be repleced in a diffrent place
// extension CamraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//      print("did finish lunch")
//      print(info)
//
//        if let videoUrl = info["UIImagePickerControllerMediaURL"] as? URL {
////        if let thumnailImage = self.thumbnailImageForFileUrl(videoUrl) {
////            selectedImage = thumnailImage
////            photo.image = thumnailImage
////            self.videoUrl = videoUrl
////        }
//        dismiss(animated: true, completion: nil)
//        }
//        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
//            selectedImage = image
//            photo.image = image
//            dismiss(animated: true, completion: {
//                self.performSegue(withIdentifier: "filter_segue", sender: nil)
//            })}
//  }
//
//  func thumbnailImageForFileUrl(_ fileUrl: URL) -> UIImage? {
//      let asset = AVAsset(url: fileUrl)
//       let imageGenerator = AVAssetImageGenerator(asset: asset)
//       imageGenerator.appliesPreferredTrackTransform = true
//      do{
////        let thumbailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 7, timescale: 1), actualTime: nil)
////         return UIImage(cgImage: thumbailCGImage)
//     }
//   }
//    @IBAction func remove_TouchUpInside(_ sender: Any) {
////        clean()
//        handlePost()
//    }
////    func clean() {
////           self.captionTextView.text = ""
////           self.photo.image = UIImage(named:"placeholder-photo-1")
////           self.selectedImage = nil
////       }
////
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "filter_segue" {
////            let filterVC = segue.destination as! FilterViewController
////            filterVC.selectedImage = self.selectedImage
////            filterVC.delegate = self
//        }
//    }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
}

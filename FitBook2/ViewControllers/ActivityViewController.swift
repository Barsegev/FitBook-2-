//
//  ActivityViewController.swift
//  FitBook2
//
//  Created by BAR SEGEV on 5/25/20.
//  Copyright © 2020 BAR SEGEV. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    @IBOutlet weak var inviteFriends: UIButton!
    @IBOutlet weak var circularImage: UIImageView!
    @IBOutlet weak var weightTextField: UITextField!

    @IBOutlet weak var heightTextField: UITextField!

    @IBOutlet weak var resultTextField: UILabel!
    override func viewDidLoad() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        super.viewDidLoad()
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
            
        }
        
   
        
    }

    @IBAction func inviteFriends(_ sender: Any) {
        if let urlStr = NSURL(string: "https://itunes.apple.com/us/app/myapp/idxxxxxxxx?ls=1&mt=8") {
            let objectsToShare = [urlStr]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            if UIDevice.current.userInterfaceIdiom == .pad {
                if let popup = activityVC.popoverPresentationController {
                    popup.sourceView = self.view
                    popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                }
            }

            self.present(activityVC, animated: true, completion: nil)
        }
    }
    @IBAction func calculateBtn(_ sender: Any) {
        guard let weightInKG = weightTextField.text,
            let heightInCM = heightTextField.text else {
                return
        }
        let cm = CalculatorBrain(weightInKG: weightInKG, heightInCM: heightInCM)
        let result = cm.calcBmi()
        resultTextField.text = "BMI: \(result)"
    }

    }
struct CalculatorBrain {
let weightInKG: Double
let heightInCM: Double

init(weightInKG: String, heightInCM: String) {
    self.weightInKG = Double(weightInKG) ?? 0.0
    self.heightInCM = Double(heightInCM) ?? 0.0
}

func calcBmi() -> Double {
    return weightInKG / ((heightInCM / 100) * (heightInCM / 100))
}
}

//
//  HomeViewController.swift
//  FitBook2
//
//  Created by BAR SEGEV on 5/25/20.
//  Copyright © 2020 BAR SEGEV. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase






class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        loadPosts()
        

    }
    func loadPosts() {
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot: DataSnapshot) in
            print(snapshot.value)
            

        }
        
    }
    
    @IBAction func logout_TouchUpInside(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            self.present(signInVC, animated: true, completion:nil)
            
        } catch let logoutError {
            print(logoutError)
        }
           
        }
        
    }

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        cell.imageView?.image = UIImage.init(named: "logo")
        if indexPath.row%4 == 0
        {
            cell.imageView?.image = UIImage.init(named: "350350l")

        }else if indexPath.row%3 == 0{
            cell.imageView?.image = UIImage.init(named: "350350r")

        }else if indexPath.row%2 == 0{
                  cell.imageView?.image = UIImage.init(named: "3502")

            }else if indexPath.row%1 == 0{
            cell.imageView?.image = UIImage.init(named: "Aya21")

                      
                   
              }
        

        cell.textLabel!.text = "feed"
        cell.backgroundColor = UIColor.black
        return cell
    }
    
  
}

//extension HomeViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt
//        indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
//        cell.textLabel?.text = "\(indexPath.row)"
//        cell.imageView?.image = UIImage.init(named: "logo")
//        if indexPath.row%2 == 0
//        {
//            cell.imageView?.image = UIImage.init(named: "350350l")
//
//        }else{
//            cell.imageView?.image = UIImage.init(named: "350350r")
//
//        }
//
//
//        cell.textLabel!.text = "feed"
//        cell.backgroundColor = UIColor.black
//        return cell
//    }
//
//
//}
//

//
//  profileVC.swift
//  flashcardTab
//
//  Created by mac on 2018/12/21.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Parse
import Firebase
import  GoogleSignIn

import FirebaseCore
import  FirebaseAuth

class profileVC: UIViewController {
    @IBOutlet weak var profileIDLBL: UILabel!
    
    @IBOutlet weak var profileNameLBL: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileEmailLBL: UILabel!
    
    @IBOutlet weak var profileTelephoneLBL: UILabel!
    var ImageURL = "" as String
    
  
  
 
    override func viewDidLoad() {
        super.viewDidLoad()
   
      
   
        if myClass.shared.googleGirisimiYapildi == "googlegirisyapildi"{
    
        
        let user = Auth.auth().currentUser

        
let myImageURL = user?.photoURL
        self.profileIDLBL.text = user?.uid
        self.profileNameLBL.text = user?.displayName
        self.profileEmailLBL.text = user?.email
       
            
            let request = URLRequest(url: myImageURL!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(" resim gelmedi")
                }else{
                    if let incomingData = data{
                        let image = UIImage(data: incomingData)
                        DispatchQueue.main.sync(execute: {
                            self.profileImageView.image = image
                        })
                    }
                }
        }
        task.resume()
        }
        else{
            let user = PFUser.current()
            self.profileNameLBL.text = user?.username
            self.profileEmailLBL.text = user?.email
            
        }
        
    }
    
    
    @IBAction func logOutClicked(_ sender: Any) {
        
        if myClass.shared.googleGirisimiYapildi == "googlegirisyapildi"{
            
            let googleCikis = Auth.auth()
            do{
                try googleCikis.signOut()
                
            }catch let signOutError as NSError   {
                print(signOutError)
            }
        }
        
        
        
        
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "error", message: "logot error", preferredStyle: UIAlertController.Style.alert)
                let button = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(button)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.synchronize()
                
         
                myClass.shared.myClassID = ""
                myClass.shared.myClassEmail = ""
                myClass.shared.myClassName = ""
                myClass.shared.myClassimageURL = ""

                let signin = self.storyboard?.instantiateViewController(withIdentifier: "signin") as! signInVC
                
                
                let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
               delegate.window?.rootViewController = signin
                delegate.rememberUser()
                
            }
        }
        
    }
    
    }

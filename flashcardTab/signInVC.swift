//
//  signInVC.swift
//  flashcardTab
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit





class signInVC: UIViewController , FBSDKLoginButtonDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        
        loginButton.readPermissions = ["public_profile", "email"]
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logget out")
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
print("cant log in")
            return
        }else {
            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name,email,picture"]).start{ (connection, result, error) in
                if error != nil{
                    print("error cant reach info ")
                }
             
                print(result!)
                let sonuc = result as? [String:AnyObject]
                  let fbUserID = sonuc?["id"] as? String
                let fbUserName = sonuc?["name"] as? String
                let fbUserEmail = sonuc?["email"] as? String
                let fbUserPicture = sonuc?["picture"] as? [String:AnyObject]
                let data = fbUserPicture?["data"] as? [String:AnyObject]
                let fbUserimageURL = data?["url"] as! String
                print(fbUserID!)
                print(fbUserName!)
                print(fbUserEmail!)
                
                myClass.shared.myClassEmail = fbUserEmail!
                myClass.shared.myClassID = fbUserID!
                myClass.shared.myClassName = fbUserName!
                myClass.shared.myClassimageURL = fbUserimageURL
    
                self.performSegue(withIdentifier: "toTabbar", sender: nil)

     
            }
                
            }

            }
    
        }
    
  
  



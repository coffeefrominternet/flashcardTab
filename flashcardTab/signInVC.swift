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

       let fbLoginBTN = FBSDKLoginButton()
        view.addSubview(fbLoginBTN)
        fbLoginBTN.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        fbLoginBTN.delegate = self
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logget out")
        
        
    }
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("success logged in")
        }
        
    }
    
  
  
}

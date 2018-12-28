//
//  signInVC.swift
//  flashcardTab
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

import Parse






class signInVC: UIViewController  , GIDSignInUIDelegate , UIApplicationDelegate {
  
    
  
    @IBOutlet weak var signINOKBTN: UIButton!
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!

    @IBOutlet weak var faceBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupGoogleBTN()

        emailTF.isHidden = true

       
    }
    
    
    
 fileprivate  func setupGoogleBTN(){
        
        //google button
        let googleBTN = GIDSignInButton()
        googleBTN.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        view.addSubview(googleBTN)
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
    }

    
    
    
   
    
    
    
     var chosenEnter = "signIN"
    @IBAction func signInClicked(_ sender: Any) {
        
       emailTF.isHidden = true
        chosenEnter = "signIN"
        if self.emailTF.isHidden == false {
            self.emailTF.isHidden = true
            
        }        }
      
    
    @IBAction func signUpClicked(_ sender: Any) {
        chosenEnter = "signUp"
        if self.emailTF.isHidden == true {
            self.emailTF.isHidden = false
          
        }
        
    }
    
   
    @IBAction func sigInOkClicked(_ sender: Any) {
        if chosenEnter == "signUp" {
            if usernameTF.text != "" && emailTF.text != "" && passwordTF.text != "" {
                signINOKBTN.isHidden = false
                
                let user = PFUser()
                
                
                user.username = usernameTF.text!
                user.email = emailTF.text!
                user.password = passwordTF.text!
            
                myClass.shared.myClassName = usernameTF.text!
                myClass.shared.myClassEmail = emailTF.text!

                
                user.signUpInBackground { (success, error) in
                    if error != nil {
                        let alert = UIAlertController(title: error?.localizedDescription, message: "sign up error", preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        
                        UserDefaults.standard.set(user.username, forKey: "username")
                        UserDefaults.standard.synchronize()
                        
                        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        delegate.rememberUser()
                    }
                }}
            else{
                
                let alert = UIAlertController(title: "error", message: "please fill areas", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            if chosenEnter == "signIN"{
                
                if usernameTF.text != "" && passwordTF.text != "" {
 PFUser.logInWithUsername(inBackground: usernameTF.text!, password: passwordTF.text!) { (user, error) in
                        
                        if error != nil {
                            
                            
                            let alert = UIAlertController(title: "error", message: "fill empty areas", preferredStyle: UIAlertController.Style.alert)
                            let button  = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
                            alert.addAction(button)
                            self.present(alert, animated: true, completion: nil)
                            
                        }else {
                            
                            
                            UserDefaults.standard.set(user!.username, forKey: "username")
                            UserDefaults.standard.synchronize()
                            let delegate: AppDelegate = UIApplication.shared.delegate  as! AppDelegate
                            delegate.rememberUser()
                            
                        }
                    }
                    
                }else{
                    let alert = UIAlertController(title: "alert", message: "please fill empty areas", preferredStyle: UIAlertController.Style.alert)
                    let button = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
                    
                    alert.addAction(button)
                    self.present(alert, animated: true, completion: nil)
                }
        }
        
        }
        
    }

    }
    
    
    
    
    

    
  
  



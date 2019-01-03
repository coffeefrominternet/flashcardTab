//
//  bazikodlar.swift
//  flashcardTab
//
//  Created by mac on 2018/12/26.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
/*  let query = PFQuery(className: "myList")
 
 query.findObjectsInBackground { (objects, error) in
 
 if error != nil {
 let alert = UIAlertController(title: "error", message: "get-data error", preferredStyle: UIAlertController.Style.alert)
 let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
 alert.addAction(okButton)
 self.present(alert, animated: true, completion: nil)
 }else{
 if objects != nil {
 
 
 for object in objects!{
 
 
 print(object["kelimelerim"] as! String )
 
 myWordsList.insert(object["kelimelerim"] as! String, at: 0)
 
 
 
 // myWordsList.append(object["kelimelerim"] as! String)
 }}
 
 if objects != nil{
 
 for object in objects!{
 
 
 myPicturesList.insert(object["resimlerim"] as! PFFileObject, at: 0)
 
 
 
 // myPicturesList.append(object.object(forKey: "resimlerim") as! PFFileObject)
 
 
 }}
 self.cardListTableView.reloadData()
 
 
 
 }
 
 }*//* 
 let user = Auth.auth().currentUser
 let userUID = user?.uid
 let userName = user?.displayName
 let userPhotoURL = user?.photoURL
 let userPhoneNumber = user?.phoneNumber
 let userEmail = user?.email
 
 UserDefaults.standard.set(user?.displayName, forKey: "username")
 UserDefaults.standard.synchronize()
 
 let pfObject = PFObject(className: "googleUsers")
 pfObject["UID"] = userUID
 pfObject["email"] = userEmail
 pfObject["username"] = userName
 pfObject["photoUrl"] = userPhotoURL
 pfObject["phoneNumber"] = userPhoneNumber
 
 
 
 
 
 pfObject.saveInBackground { (success, error) in
 if error != nil {
 print("google parse error")
 }else{
 print("saved")
 }        }
func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    PFUser.logOutInBackground { (error) in
        if error != nil {
            let alert = UIAlertController(title: "error", message: "logot error", preferredStyle: UIAlertController.Style.alert)
            let button = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(button)
            self.present(alert, animated: true, completion: nil)
            
        }else{
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.synchronize()
            let signin = self.storyboard?.instantiateViewController(withIdentifier: "signin") as! signInVC
            
            
            let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            delegate.window?.rootViewController = signin
            delegate.rememberUser()
            
        }
    }
    
}






func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    if error != nil{
        print("error")
        return
    }else{
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name,email,picture"]).start{ (connection, result, error) in
            if error != nil{
                print("error cant reach info ")
            }
            if result != nil {
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
                myClass.shared.myClassName = fbUserName!
                myClass.shared.myClassEmail = fbUserEmail!
                myClass.shared.myClassimageURL = fbUserimageURL
                
                
                let user = PFUser()
                user.setObject(myClass.shared.myClassName, forKey: "username")
                user.setObject(myClass.shared.myClassEmail, forKey: "email")
                user.setObject(myClass.shared.myClassimageURL, forKey: "profilepictureuRL")
                
                user.saveInBackground(block: { (success, error) in
                    if error != nil {
                        print("error")
                    }else{
                        UserDefaults.standard.set(myClass.shared.myClassName, forKey: "username")
                        UserDefaults.standard.synchronize()
                        self.performSegue(withIdentifier: "toTabbar", sender: nil)
                        
                    }
                })
            }
        }
        
    }
    
}


*/
    

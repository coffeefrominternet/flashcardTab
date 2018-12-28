//
//  AppDelegate.swift
//  flashcardTab
//
//  Created by mac on 2018/12/14.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Parse

import Firebase
import GoogleSignIn
import FirebaseCore
import  FirebaseAuth
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,GIDSignInDelegate{
  
    
    

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        
        let configuration = ParseClientConfiguration { (ParseMutableClientConfiguration) in
            ParseMutableClientConfiguration.applicationId = "2yDDJhP1X38NGllYYot5NMp4IoJMbAP19RPdmxEF"
            ParseMutableClientConfiguration.clientKey = "ZA5L6cd2VpUVCX317Ery6Gk4QmC0kw306oMdjAzr"
            ParseMutableClientConfiguration.server = "https://parseapi.back4app.com/"
        }
        Parse.initialize(with: configuration)

        let acl = PFACL()
        acl.hasPublicReadAccess = true
        acl.hasPublicWriteAccess = true
        PFACL.setDefault(acl, withAccessForCurrentUser: true)
        
   
        //    UIApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
        rememberUser()

        
        

        return true
    }
  
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error{
            print("google girrilemedi")
            print(err)
            return
        }
        print("giris basarili")
        print(user)
        guard let idToken = user.authentication.idToken else {return}
        guard let idaccessToken = user.authentication.accessToken else {return}
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: idaccessToken)
        Auth.auth().signInAndRetrieveData(with: credentials) { (user, error) in
            if let err = error {
                print("failed account error",err)
                return
            }
          
            
            print("Success google authentification"  )
            myClass.shared.googleGirisimiYapildi = "googlegirisyapildi"
print(myClass.shared.googleGirisimiYapildi)
            let user = Auth.auth().currentUser
            myClass.shared.myClassID = (user?.uid)! 
            myClass.shared.myClassName = (user?.displayName)!
            myClass.shared.myClassEmail = (user?.email)!
            print(user?.uid as Any)
            print(myClass.shared.myClassID)
            
          
            UserDefaults.standard.set(user?.displayName, forKey: "username")
            UserDefaults.standard.synchronize()
            self.rememberUser()
            
        }
    }
            
        
    
            
            

        
    
    
    
    func rememberUser(){
        let user: String? = UserDefaults.standard.string(forKey: "username")
        if user != nil{
            let board: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBar = board.instantiateViewController(withIdentifier: "cardStoryboardID") as! UITabBarController
            window?.rootViewController = tabBar
            
        }
        
        
    }
 
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
       let googleGiris =  GIDSignIn.sharedInstance().handle(url,
                                          sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                          annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        return googleGiris
    }
    
 
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
     
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    
    
    
    
    
    
}


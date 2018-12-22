//
//  profileVC.swift
//  flashcardTab
//
//  Created by mac on 2018/12/21.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
 
class profileVC: UIViewController {
    @IBOutlet weak var profileIDLBL: UILabel!
    
    @IBOutlet weak var profileNameLBL: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileEmailLBL: UILabel!
    
    var ImageURL = "" as String
    
  
  
 
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.profileIDLBL.text = myClass.shared.myClassID
        self.profileNameLBL.text = myClass.shared.myClassName
        self.profileEmailLBL.text = myClass.shared.myClassEmail
        
ImageURL = myClass.shared.myClassimageURL
        
        if let url = URL(string: ImageURL){
            
            let request = URLRequest(url: url)
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
      
        
    }
    
    
    
    }

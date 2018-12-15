//
//  SecondViewController.swift
//  flashcardTab
//
//  Created by mac on 2018/12/14.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
var arananKelime = "bird"
class searchVC : UIViewController , UITableViewDelegate , UITableViewDataSource{
  
    

    //mark variables
    var myApiID = "7507132-6d060e01c5cf8a2e0ff1c0552"
    
    
    var resimlerArray = [UIImage]()
    var nameArray = [String]()
    
    
    
    
    //mark outlets
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBOutlet weak var searchTableView: UITableView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resimlerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for : indexPath) as! searchCellVC
        
        
        cell.searchCellImageView.image = resimlerArray[indexPath.row]
        
        
        
        return cell
    }
    
    
    
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        if searchTF.text != ""{
            
            arananKelime = searchTF.text!
        }
        
        
        let url = URL(string: "https://pixabay.com/api/?key=7507132-6d060e01c5cf8a2e0ff1c0552&q=\(arananKelime)&image_type=photo&pretty=true")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                if data != nil {
                    
                    do {
                        
                        let jSONResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        DispatchQueue.main.async {
                            // print(jSONResult["hits"])
                            
                            let hits = jSONResult["hits"] as! NSArray
                            
                            //print(hits)
                            
                            let id = hits.firstObject as! [String : AnyObject]
                            
                            //print(id)
                            
                           // if  let type = id["type"] as? String{
                                
                             //   self.nameArray.append(type)                            }
                            
                            if let fullHDURL = id["previewURL"] as? String{
                                print(fullHDURL)
                                if let url = URL(string: fullHDURL){
                                    let request = URLRequest(url: url)
                                    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                                        if error != nil {
                                            
                                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                                            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                                            alert.addAction(okButton)
                                            self.present(alert, animated: true, completion: nil)
                                            
                                            
                                        }else{
                                            if let incomingData = data{
                                                let image = UIImage(data: incomingData)
                                                DispatchQueue.main.sync(execute : {
                                                    self.resimlerArray.append(image!)
                                                    
                                                    
                                                    
                                                })
                                                
                                            }
                                                                                   }
                                                                            })
                                    task.resume()
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                    } catch {
                        
                    }
                    
                }
                
                
            }
            
            
        }
        
        task.resume()
         self.searchTableView.reloadData()
        
    }
    
        
        
        
    }
    

        
        






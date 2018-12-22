//
//  SecondViewController.swift
//  flashcardTab
//
//  Created by mac on 2018/12/14.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Parse


var arananKelime = "bird"
class searchVC : UIViewController , UITableViewDelegate , UITableViewDataSource , UINavigationControllerDelegate{
  
    
    var resimlerArray = [UIImage]()
    var kelimelerArray = [String]()
    
    
    //mark variables
    var myApiID = "7507132-6d060e01c5cf8a2e0ff1c0552"
    
    

    var yuklenecekKelime = "no word"
    var yukleyenKullanici = "eddy"
    
    
    //mark outlets
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBOutlet weak var searchTableView: UITableView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
    /*    let pfObject = PFObject(className: "myList")
        pfObject["resimlinklerim"] = "URL2"
        pfObject["kelimelerim"] = "horse"

        pfObject.saveInBackground { (success, error) in
            if error != nil {
                
         let alert = UIAlertController(title: "error", message: "get-data error", preferredStyle: UIAlertController.Style.alert)
         let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
         
         alert.addAction(okButton)
         self.present(alert, animated: true, completion: nil)
            }else{
                print("saved")
            }
        }
        */
      
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resimlerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for : indexPath) as! searchCellVC
        
        
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
                            
                            self.resimlerArray.removeAll(keepingCapacity: false)
                          //  print(hits)
                            for indexim in 0...19{
                            let id = hits[indexim] as AnyObject

                          //print(id)
                            
                           // if  let previewURL = id["previewURL"] as? String{
                                
                             //   self.nameArray.append(type)                            }
                         
                            if let fullHDURL = id["previewURL"] as? String{
                             //   print(fullHDURL)
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
                                    task.resume()}
                                }
                                }
                        }
                        }
                        catch
                        {
                        }
                }
            }
        }
        task.resume()
        
         listeyiYenile()
    }
    
    func listeyiYenile(){
        self.searchTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data2 = resimlerArray[indexPath.row].jpegData(compressionQuality: 0.5)
        let pfImage = PFFile(name: "resimlerim.png", data: data2!)
        let pfObject = PFObject(className: "myList")
        pfObject["username"] = yukleyenKullanici
        pfObject["resimlerim"] = pfImage
        pfObject["kelimelerim"] = arananKelime
        pfObject.saveInBackground { (success, error) in
            if error != nil {
                let alert = UIAlertController(title: error?.localizedDescription, message: "get-data error", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                print("saved")
            }        }

        self.tabBarController!.selectedIndex = 0
        
    }

    }
    
    
    

        
        







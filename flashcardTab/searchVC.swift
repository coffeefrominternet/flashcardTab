//
//  SecondViewController.swift
//  flashcardTab
//
//  Created by mac on 2018/12/14.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
var searchingWord = ""
class searchVC : UIViewController {

    //mark variables
    var myApiID = "7507132-6d060e01c5cf8a2e0ff1c0552"
    
    
    
    
    
    
    
    
    //mark outlets
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBOutlet weak var searchTableView: UITableView!
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        
        if searchTF.text != "bird" {
        
            searchingWord = searchTF.text!
            
        }
        getTodayResult()
        
    }
    
    
    func getTodayResult(){
        
        if let url = URL(string: "https://pixabay.com/api/?key=7507132-6d060e01c5cf8a2e0ff1c0552&q=\(searchingWord)&image_type=photo&pretty=true"
            ){
            let request = URLRequest(url: url);
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil{
                    
                    if let incomingData = data{
                        
                        do{
                            
                            let jsonResult = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject;
                            
                            print(jsonResult);
                           /* print(jsonResult["weather"])
                            
                            let weather = jsonResult["weather"] as! NSArray;
                            
                            let weather1 = weather.firstObject as! [String : AnyObject];
                            
                            if let description = weather1["description"] as? String{
                                
                                
                                
                                DispatchQueue.main.sync(execute: {
                                    self.currentWeather = description;
                                    
                                    self.tableView.reloadData();
                                })
                                
                            }
                            */
                        }catch{
                            print("burada hata oluştu");
                        }
                        
                        
                        
                    }
                    
                }
            }
            
            task.resume();
            
        }
    }
 
 
 
 }


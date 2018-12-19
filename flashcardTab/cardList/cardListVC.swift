//
//  FirstViewController.swift
//  flashcardTab
//
//  Created by mac on 2018/12/14.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Parse



var myWordsList = [String]()
var myPicturesList = [PFFile]()
class cardListVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
  
   
    
 
    
    
    
    //mark outlets
    
    @IBOutlet weak var cardListTableView: UITableView!
    
    var refreshAction = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardListTableView.delegate = self
        cardListTableView.dataSource = self
        
        refreshAction.addTarget(self, action: #selector(refreshNow), for: UIControl.Event.valueChanged)
        refreshAction.tintColor = UIColor.blue
        self.cardListTableView.addSubview(refreshAction)
        
    }
  
    
    
    override func viewWillAppear(_ animated: Bool) {
        getData()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPicturesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! cardlistCell
        cell.cardListCellLBL.text = myWordsList[indexPath.row]
        
        myPicturesList[indexPath.row].getDataInBackground { (data, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
           
            }else{
                
                cell.cardListCellImageView.image = UIImage(data: data!)
                
            }
            
        }

        return cell
        }
    
    @objc func refreshNow(){
        
        self.refreshAction.endRefreshing()
        getData()
       
    }
    
    func getData(){
        myPicturesList.removeAll(keepingCapacity: false)
        myWordsList.removeAll(keepingCapacity: false)
        let query = PFQuery(className: "myList")
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
                        myWordsList.append(object["kelimelerim"] as! String)
                    }}
                
                if objects != nil{
                    
                    for object in objects!{
                        
                        myPicturesList.append(object.object(forKey: "resimlerim") as! PFFile)
                        
                        
                    }}
                self.cardListTableView.reloadData()
                
                
                
            }
            
        }
    }
}


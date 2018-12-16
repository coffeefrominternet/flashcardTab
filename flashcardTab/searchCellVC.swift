//
//  searchCell.swift
//  flashcardTab
//
//  Created by mac on 2018/12/14.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit


class searchCellVC: UITableViewCell {

    
    var Mylist = [AnyObject]()
    var myWords = [String]()
    
    
    
    // mark outlets
    
    
    @IBOutlet weak var searchCellImageView: UIImageView!
    
    @IBOutlet weak var searchCellChooseBTN: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
      
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func chooseClicked(_ sender: Any) {
        
        Mylist.append(searchCellImageView.image!)
        
        myWords.append(arananKelime)
        
        
      
        let tabBarController = UITabBarController()
        tabBarController.selectedIndex = 0
    }
  
    
}

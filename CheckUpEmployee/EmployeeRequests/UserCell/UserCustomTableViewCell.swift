//
//  UserCustomTableViewCell.swift
//  Checkup
//
//  Created by azab on 5/14/20.
//  Copyright © 2020 Hassan Khamis. All rights reserved.
//

import UIKit

class UserCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    ///    @IBOutlet weak var userAddress: UILabel!
    
    @IBOutlet weak var generatedCodeText: UILabel!
    
    @IBOutlet weak var dateTimeText: UILabel!
    
   
    @IBAction func getDirectionBtn(_ sender: Any) {
            getDirectionClosure?()
        
    }
    
    @IBOutlet weak var getDirectionBtnOutlet: UIButton!
    var  getDirectionClosure : (()->())?
    var calMeClouser : (()->())?
    /*
     No need to keep track the index since we are using closure to store the function that will be executed when user tap on it.
     */
    
    // the closure, () -> () means take no input and return void (nothing)
    // it is wrapped in another parentheses outside in order to make the closure optional
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Add action to perform when the button is tapped
//        self.getDirectionBtnOutlet.addTarget(self, action: #selector(getDirectionButtonTapped(_:)), for: .touchUpInside)
//
//        self.callMeBtnOutlet.addTarget(self, action: #selector(callMeButtonTapped(_:)), for: .touchUpInside)
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
          userImg.layer.cornerRadius = userImg.frame.width / 2
        // Configure the view for the selected state
        // userImg.layer.cornerRadius=userImg.frame.width / 2
    }
    
//    @objc func getDirectionButtonTapped(_ sender: UIButton){
//        // if the closure is defined (not nil)
//        // then execute the code inside the getDirectionClosure closure
//        getDirectionClosure?()
//
//    }
//
//    @objc func callMeButtonTapped(_ sender :UIButton){
//
//        calMeClouser?()
//    }
    
    
    
    
}


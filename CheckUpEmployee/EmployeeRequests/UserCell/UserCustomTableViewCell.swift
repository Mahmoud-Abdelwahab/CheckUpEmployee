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
    
    @IBOutlet weak var userAddress: UILabel!
    
    @IBAction func getDirectionBtn(_ sender: Any) {
    }
    @IBAction func callUserBtn(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        userImg.layer.cornerRadius=userImg.frame.width / 2
    }
    
}

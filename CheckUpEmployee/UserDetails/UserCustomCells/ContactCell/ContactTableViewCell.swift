//
//  ContactTableViewCell.swift
//  CheckUpEmployee
//
//  Created by Hassan Khamis on 6/5/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var phoneTypeImage: UIImageView!
    @IBOutlet weak var phoneNumberTxt: UILabel!

    @IBOutlet weak var callBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

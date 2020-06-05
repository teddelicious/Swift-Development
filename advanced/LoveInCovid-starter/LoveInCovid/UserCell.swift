//
//  UserCell.swift
//  LoveInCovid
//
//  Created by John Lin on 2020-06-02.
//  Copyright © 2020 Parrot. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var txtMessage: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

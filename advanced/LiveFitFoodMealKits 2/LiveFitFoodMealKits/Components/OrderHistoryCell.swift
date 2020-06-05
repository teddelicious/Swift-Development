//
//  OrderHistoryCell.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-06-01.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class OrderHistoryCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    
    //MARK: Variables
    
    //MARK: Overridden & implemented functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

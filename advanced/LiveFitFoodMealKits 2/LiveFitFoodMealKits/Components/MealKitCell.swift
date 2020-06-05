//
//  MealKitCell.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-05-31.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class MealKitCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    //MARK: Variables
    var delegate: MealKitCellDelegate?
    var index: IndexPath!
    
    //MARK: Helper functions
    
    //MARK: Overridden & implemented functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Actions
}

protocol MealKitCellDelegate {
    func mealKitRowSelected(index: Int)
}

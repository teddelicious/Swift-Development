//
//  PatientTableViewCell.swift
//  Swift-19-App
//
//  Created by John Lin on 2020-04-13.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class PatientTableViewCell: UITableViewCell {
    
    // MARK: OUTLETS
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelPriority: UILabel!
    @IBOutlet weak var labelRecentlyTraveled: UILabel!
    
    // MARK: Mandatory Delegate Variables
    var delegate: PatientCellDelegate?
    
    //MARK: custom properties
    var index: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

// add protocol definition for delegate
protocol PatientCellDelegate {
    func patientRowSelected(index: Int)
}


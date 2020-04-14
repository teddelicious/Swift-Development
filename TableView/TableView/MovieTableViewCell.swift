//
//  MovieTableViewCell.swift
//  TableView
//
//  Created by John Lin on 2020-03-31.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: OUTLETS
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    // MARK: Mandatory Delegate Variables
    var delegate: MovieCellDelegate?
    
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
    
    @IBAction func onPressed(_ sender: Any) {
        self.delegate?.movieButtonPressed(at: self.index)
    }
    
}

// add protocol definition for delegate
protocol MovieCellDelegate {
    func movieButtonPressed(at indexPath: IndexPath)
}

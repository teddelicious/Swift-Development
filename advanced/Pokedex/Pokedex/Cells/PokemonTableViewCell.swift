//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by John Lin on 2020-05-25.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var tvName: UITextView!
    @IBOutlet weak var tvBaseExp: UITextView!
    
    //MARK: Variables
    var delegate: PokemonCellDelegate?
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
protocol PokemonCellDelegate {
    func pokemonRowSelected(index: Int)
}

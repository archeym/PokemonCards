//
//  PokeyTableViewCell.swift
//  PokemonCards
//
//  Created by Arkadijs Makarenko on 21/04/2023.
//

import UIKit
import SDWebImage

class PokeyTableViewCell: UITableViewCell {

    @IBOutlet weak var pokeyImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var supertypeLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    
    
    func setupUI(withDataFrom: Card){
        
        nameLabel.text = "Name: " + withDataFrom.name
        hpLabel.text = "Health points: " + (withDataFrom.hp ?? "0")
        supertypeLabel.text = (withDataFrom.supertype ?? "")
        pokeyImageView.sd_setImage(with: URL(string: withDataFrom.imageURL))

        #warning("paint Trainer cell to different color")
    }
    
}

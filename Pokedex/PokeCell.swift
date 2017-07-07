//
//  PokeCell.swift
//  Pokedex
//
//  Created by baytoor on 7/7/17.
//  Copyright © 2017 Baytur. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5
    }
    
    func configureCell (_ pokemon: Pokemon){
        
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalized
        thumImg.image = UIImage(named: "\(self.pokemon.id)")
    }
}

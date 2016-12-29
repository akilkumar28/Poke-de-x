//
//  PokeCell.swift
//  Pokédèx
//
//  Created by AKIL KUMAR THOTA on 12/29/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.layer.cornerRadius = 5.0
//    }
    
    func ConfigureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLbl.text = pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(pokemon.pokemonId)")
    }
    
}

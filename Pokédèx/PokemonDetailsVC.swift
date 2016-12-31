//
//  PokemonDetailsVC.swift
//  Pokédèx
//
//  Created by AKIL KUMAR THOTA on 12/30/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {
    
    var pokemon : Pokemon!

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttkLbl: UILabel!
    @IBOutlet weak var nxtEvoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var loadinganimation: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = pokemon.name
        
       loadinganimation.startAnimating()
        pokemon.downloadData {
            
            self.updateUI()
            if self.descriptionLbl.text != nil {
                self.loadinganimation.stopAnimating()
                self.loadinganimation.isHidden = true
            }


        }

    }
    
    func updateUI(){
        
        titleLbl.text = pokemon.name.capitalized
        defenceLbl.text = "\(pokemon.defence)"
        heightLbl.text = pokemon.height
        pokedexIdLbl.text = "\(pokemon.pokemonId)"
        weightLbl.text = pokemon.weight
        thumbImg.image = UIImage(named: "\(pokemon.pokemonId)")
        baseAttkLbl.text = "\(pokemon.baseAttack)"
        typeLbl.text = pokemon.type
        currentEvoImg.image = thumbImg.image
        descriptionLbl.text = pokemon.description
//        nxtEvoLbl.text = "Next Evolution: \(pokemon.nextEvoName)"
        
        if pokemon.nextEvoId == "" {
            nextEvoImg.isHidden = true
            arrowImg.isHidden = true
            nxtEvoLbl.text = "No Evolution"

        } else {
            nextEvoImg.image = UIImage(named: "\(pokemon.nextEvoImg)")
            nxtEvoLbl.text = "Next Evolution: \(pokemon.nextEvoName)"

        }
    }

    @IBAction func backBtnPrsd(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
 
}

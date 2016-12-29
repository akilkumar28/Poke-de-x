//
//  Pokemon.swift
//  Pokédèx
//
//  Created by AKIL KUMAR THOTA on 12/29/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokemonId :Int!
    
    var name : String {
        get {
            return self._name
        } set {
            self._name = newValue
        }
    }
    
    var pokemonId : Int {
        get{
            return self._pokemonId
        } set {
            self._pokemonId = newValue
        }
    }
    
    init(name: String, PokemonId : Int) {
        
        self._name = name
        self._pokemonId = PokemonId
    }
}

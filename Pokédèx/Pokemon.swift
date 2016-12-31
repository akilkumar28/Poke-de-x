//
//  Pokemon.swift
//  Pokédèx
//
//  Created by AKIL KUMAR THOTA on 12/29/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokemonId :Int!
    private var _type: String!
    private var _defence: Int!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: Int!
    private var _description: String!
    private var _pokeUrl: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoImg: String!

    var nextEvoImg: String {
        get {
            return self._nextEvoImg
        } set {
            self._nextEvoImg = newValue
        }
    }
    var nextEvoName: String {
        get {
            if self._nextEvoName == nil {
                self._nextEvoName = ""
            }
            return self._nextEvoName
        } set {
            self._nextEvoName = newValue
        }
    }
    
    var nextEvoId: String {
        get {
            if self._nextEvoId == nil {
                self._nextEvoId = ""
            }
            return self._nextEvoId
        } set {
            self._nextEvoId = newValue
        }
    }
    var pokeUrl: String {
        get {
            return self._pokeUrl
        } set {
            self._pokeUrl = newValue
        }
    }
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
    
    var type : String {
        get{
            return self._type
        } set {
            self._type = newValue
        }
    }
    
    var defence : Int {
        get{
            if self._defence == nil {
                self._defence = 0
            }
            return self._defence
        } set {
            self._defence = newValue
        }
    }
    
    var height : String {
        get{
            if self._height == nil {
                self._height = ""
            }
            return self._height
        } set {
            self._height = newValue
        }
    }
    
    var weight : String {
        get{
            if self._weight == nil {
                self._weight = ""
            }
            return self._weight
        } set {
            self._weight = newValue
        }
    }
    
    var baseAttack : Int {
        get{
            return self._baseAttack
        } set {
            self._baseAttack = newValue
        }
    }
    
    var description : String {
        get{
            if self._description == nil {
                self._description = ""
            }
            return self._description
        } set {
            self._description = newValue
        }
    }
    
    
    init(name: String, PokemonId : Int) {
        
        self.name = name
        self.pokemonId = PokemonId
        self.pokeUrl = "\(FUll_URL)\(Full_Url2)\(self.pokemonId)"
        
    }
    
    
    
    func downloadData(complete: @escaping downloadComplete) {
        Alamofire.request(pokeUrl).responseJSON { response in
            
            let result = response.result
            let value = result.value
            if let dict = value as? Dictionary<String,AnyObject> {
                
                if let name = dict["name"] as? String {
                    self.name = name
                }
                if let weight1 = dict["weight"] as? String {
                    self.weight = weight1
                }
                if let height1 = dict["height"] as? String {
                    self.height = height1
                }
                if let defense1 = dict["defense"] as? Int {
                    self.defence = defense1
                }
                if let attack1 = dict["attack"] as? Int {
                    self.baseAttack = attack1
                }
                if let typesarray = dict["types"] as? [Dictionary<String,String>] {
                    self.type = ""
                    let count = typesarray.count
                    if let typename = typesarray[0]["name"] {
                        self.type = typename.capitalized
                    }
                    if count > 1 {
                        for x in 1..<count {
                            if let typenamemultiple = typesarray[x]["name"] {
                                self.type += "/\(typenamemultiple.capitalized)"
                            }
                        }
                    }
                }
                
                if let descriptionArray = dict["descriptions"] as? [Dictionary<String,String>] {
                    if let newUrl = descriptionArray[0]["resource_uri"] {
                        let secondURL = "\(FUll_URL)\(newUrl)"
                        Alamofire.request(secondURL).responseJSON{ response in
                            if let dict1 = response.result.value as? Dictionary<String,AnyObject> {
                                if let detail = dict1["description"] as? String {
                                    let newDesc = detail.replacingOccurrences(of: "POKMON" , with: "Pokemon")
                                    self.description = newDesc
                                    print(self.description)
                                }
                            }
                            complete()
                        }
                    }
                } else {
                    self.description = ""
                }
                
                if let evolution = dict["evolutions"] as? [Dictionary<String,AnyObject>], evolution.count > 0 {
                    if let evoName = evolution[0]["to"] as? String {
                        if evoName.range(of: "mega") == nil {
                            self.nextEvoName = evoName
                            if let nextid = evolution[0]["resource_uri"] as? String {
                                let str = nextid.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let newStr = str.replacingOccurrences(of: "/", with: "")
                                self.nextEvoId = newStr
                                self.nextEvoImg = newStr
                            }
                    }
                    }
                   
                }

            }
            complete()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

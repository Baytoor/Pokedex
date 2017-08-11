//
//  Pokemon.swift
//  Pokedex
//
//  Created by baytoor on 7/7/17.
//  Copyright © 2017 Baytur. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _id: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoTxt: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoLevel: String!
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    var id: Int {
        return _id
    }
    var discription: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type: String {
        if _type == nil{
            _type = ""
        }
        return _type
    }
    var weight: String {
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    var height: String {
        if _height == nil{
            _height = ""
        }
        return _height
    }
    var attack: String {
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    var defense: String {
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    var nextEvoTxt: String {
        if _nextEvoTxt == nil{
            _nextEvoTxt = ""
        }
        return _nextEvoTxt
    }
    var nextEvoName: String {
        if _nextEvoName == nil{
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    var nextEvoId: String {
        if _nextEvoId == nil{
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    var nextEvoLevel: String {
        if _nextEvoLevel == nil{
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    init(name: String, id: Int) {
        self._name = name
        self._id = id
        
        self._pokemonUrl = "\(urlBase)\(urlPokemon)\(self.id)/"
        
        
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonUrl, method:.get).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, Any> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, Any>], types.count > 0 {
                    if let name = types[0]["name"] as? String {
                        self._type = name.capitalized
                    }

                    if types.count > 1{
                        for x in 1..<types.count {
                            if let name = types[x]["name"] as? String {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                }
                
                if let desc = dict["descriptions"] as? [Dictionary<String, Any>] {
                    
                    if let descUrl = desc[0]["resource_uri"] as? String {
                        let urlDesc = urlBase + descUrl
                        
                        Alamofire.request(urlDesc, method:.get).responseJSON(completionHandler: { (response) in
                            if let descDict = response.result.value as? Dictionary<String,Any> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    self._description = description
//                                    print(self._description)
                                }
                            }
                            completed()
                        })
                    }
                }
                
                if let evo = dict["evolutions"] as? [Dictionary<String, Any>] , evo.count > 0  {
                    
                    if let nextEvolName = evo[0]["to"] as? String {
                        
                        if nextEvolName.range(of: "mega") == nil {
                            self._nextEvoName = nextEvolName
                            
                            if let uri = evo[0]["resource_uri"] as? String {
                                let newStr =  uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvolId = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvoId = nextEvolId
                                
                                if let lvlExists = evo[0]["level"] as? Int {
                                    
                                   self._nextEvoLevel = "\(lvlExists)"
                                    
                                } else {
                                    self._nextEvoLevel = ""
                                }
                            }
                        } else {
                            self._nextEvoId = "x"
                        }
                        
                    }
                    
                }
                
//                print(self.nextEvoName)
//                print(self.nextEvoId)
//                print(self.nextEvoLevel)

                
            }
            completed()
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

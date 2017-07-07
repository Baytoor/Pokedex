//
//  Pokemon.swift
//  Pokedex
//
//  Created by baytoor on 7/7/17.
//  Copyright © 2017 Baytur. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _id: Int!
    
    var name: String {
        return _name
    }
    
    var id: Int {
        return _id
    }
    
    init(name: String, id: Int) {
        self._name = name
        self._id = id
    }
}

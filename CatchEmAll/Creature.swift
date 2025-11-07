//
//  Creature.swift
//  CatchEmAll
//
//  Created by Malek Aloulou on 10/27/25.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    var name : String
    var url: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case url
    }
    
}

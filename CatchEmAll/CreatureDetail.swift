//
//  CreatureDetail.swift
//  CatchEmAll
//
//  Created by Malek Aloulou on 10/27/25.
//

import Foundation

//
//  Creatures.swift
//  CatchEmAll
//
//  Created by Malek Aloulou on 10/27/25.
//

import Foundation

@Observable
class CreatureDetail{
    private struct Returned : Codable{
        var height: Double
        var weight: Double
        var sprites: Sprite
        
    }
    
    struct Sprite: Codable{
        var other: Other
    }
    
    struct Other: Codable{
        var officialArtwork : OfficialArtWork
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    
    struct OfficialArtWork: Codable{
        var front_default: String?
    }
    
    
    
    var urlString = "" // update later on
    
    var height = 0.0
    var weight = 0.0
    var imageUrl = ""
    
    
    
    
    
    func getData() async {
        print("We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Error: could not create a url from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("Error: Could not get data from \(urlString)")
                return
            }
            self.height = returned.height
            self.weight = returned.weight
            self.imageUrl = returned.sprites.other.officialArtwork.front_default ?? "n/a" 
    
        } catch {
            print("Error: Could not get data from \(urlString)")
        }
    }
    
}


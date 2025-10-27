//
//  Creatures.swift
//  CatchEmAll
//
//  Created by Malek Aloulou on 10/27/25.
//

import Foundation

@Observable
class Creatures{
    private struct Returned : Codable{
        var count: Int
        var next: String?
        var results: [Creature]
    }
    
    
    
    var urlString = "https://pokeapi.co/api/v2/pokemon"
    var count = 0
    var creaturesArray: [Creature] = []
    var isLoading = false
    
    
    
    
    
    func getData() async {
        print("We are accessing the url \(urlString)")
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            print("Error: could not create a url from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("Error: Could not get data from \(urlString)")
                isLoading = false
                return
            }
            Task{@MainActor in
                self.count = returned.count
                self.urlString = returned.next ?? ""
                self.creaturesArray = self.creaturesArray + returned.results
                isLoading = false
            }
           
        } catch {
            print("Error: Could not get data from \(urlString)")
            isLoading = false
        }
    }
    
}

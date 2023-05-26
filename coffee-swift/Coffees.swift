//
//  Coffees.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 25/05/23.
//

import Foundation

struct Coffee: Codable, Identifiable {
    let id = UUID()
    var name: String
    var price: Int
    var description: String
}

struct CoffeeShopInterface: Codable, Identifiable {
    let id = UUID()
    var name: String
    var rating: Float
}

class Api : ObservableObject{
    @Published var coffees = [Coffee]()
    @Published var coffeeShops = [CoffeeShopInterface]()
    
    func loadCoffeeShopsData(completion:@escaping ([CoffeeShopInterface]) -> ()) {
        guard let url = URL(string: "http://localhost:5159/api/CoffeeShop") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let coffeeShops = try! JSONDecoder().decode([CoffeeShopInterface].self, from: data!)
            print(coffeeShops)
            DispatchQueue.main.async {
                completion(coffeeShops)
            }
        }.resume()
        
    }
    
    func loadData(completion:@escaping ([Coffee]) -> ()) {
        guard let url = URL(string: "http://localhost:5159/api/Coffee") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let coffees = try! JSONDecoder().decode([Coffee].self, from: data!)
            print(coffees)
            DispatchQueue.main.async {
                completion(coffees)
            }
        }.resume()
        
    }
}

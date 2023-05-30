//
//  Coffees.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 25/05/23.
//

import Foundation



struct Coffee: Codable, Identifiable {
    var id: Int
    var name: String
    var price: Int
    var description: String
    var categories: [CoffeeCategory] = []
}

struct CoffeeCategory: Codable, Identifiable {
    var id: Int
    var name: String
}

struct CoffeeShopInterface: Codable, Identifiable {
    var id: Int
    var name: String
    var rating: Float
    var city: String
}

struct Cart: Codable {
    var coffees: [Int]
    var total: Int
}

struct CartDto: Codable {
    var coffees: [Coffee]
    var totalPrice: Int
    var productsPrice: Int
    var tip: Double
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
    
    func loadData(category: String, completion:@escaping ([Coffee]) -> ()) {
        guard var urlComponents = URLComponents(string: "http://localhost:5159/api/Coffee") else {
               print("Invalid URL...")
               return
           }
        
        urlComponents.queryItems = [URLQueryItem(name: "category", value: category)]
        
        guard let url = urlComponents.url else {
           print("Invalid URL...")
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
    
    func loadProducts(ids: [Int], completion: @escaping (CartDto) -> ()) {
            guard var urlComponents = URLComponents(string: "http://localhost:5159/api/Coffee/sumProducts") else {
                print("Invalid URL...")
                return
            }
            
            let queryItems = ids.map { URLQueryItem(name: "ids", value: String($0)) }
            urlComponents.queryItems = queryItems
            
            guard let url = urlComponents.url else {
                print("Invalid URL...")
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                let cart = try! JSONDecoder().decode(CartDto.self, from: data!)
                print(cart)
                DispatchQueue.main.async {
                    completion(cart)
                }
            }.resume()
        }
}

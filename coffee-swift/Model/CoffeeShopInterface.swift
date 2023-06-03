//
//  CoffeeShopInterface.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 02/06/23.
//

import Foundation

struct CoffeeShopInterface: Codable, Identifiable {
    var id: Int
    var name: String
    var rating: Float
    var city: String
}

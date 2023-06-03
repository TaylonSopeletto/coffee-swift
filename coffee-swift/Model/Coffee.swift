//
//  Coffee.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 02/06/23.
//

import Foundation

struct Coffee: Codable, Identifiable {
    var id: Int
    var name: String
    var price: Int
    var description: String
    var categories: [CoffeeCategory] = []
}

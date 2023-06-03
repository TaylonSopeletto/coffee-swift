//
//  CartDto.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 02/06/23.
//

import Foundation

struct CartDto: Codable {
    var coffees: [Coffee]
    var totalPrice: Int
    var productsPrice: Int
    var tip: Double
}

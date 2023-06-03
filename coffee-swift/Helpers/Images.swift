//
//  Images.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 02/06/23.
//

import Foundation

func getCoffeeImage(categories: [CoffeeCategory]) -> String {
    switch true {
        case categories.contains { $0.name == "food" }:
            return "food"
        case categories.contains { $0.name == "drink" }:
            return "drink"
        case categories.contains { $0.name == "coffee" }:
            return "coffee"
        default:
            return "unknown"
        }
}

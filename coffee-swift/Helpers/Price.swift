//
//  Price.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 02/06/23.
//

import Foundation

func getFormatedPrice(price: Int) -> String {
    let priceInDollars = Double(price) / 100.0
    let formattedPrice = String(format: "$ %.2f", priceInDollars)
    
    return formattedPrice
}

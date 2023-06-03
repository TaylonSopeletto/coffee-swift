//
//  CartCoffeeCard.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 02/06/23.
//

import SwiftUI
import Foundation

struct CartCoffeeCard: View {
        
    let name : String
    let price: Int
    let categories: [CoffeeCategory]
    
    
    var body: some View {
        HStack{
            Image(getCoffeeImage(categories: categories))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 90, height: 70)
                .cornerRadius(10)
                .padding(.leading, 20)
            
            VStack{
                Text(name)
                    .fontWeight(.semibold)
                    .frame(width: 100, height: 30, alignment: .leading)
                
                
                Text(getFormatedPrice(price: price))
                    .fontWeight(.semibold)
                    .frame(width: 100, height: 30, alignment: .leading)
                
            }
            .frame(width: 100, height: 70, alignment: .topLeading)
            
        }
    }
}
import SwiftUI

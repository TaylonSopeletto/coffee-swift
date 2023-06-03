//
//  CoffeeShopCard.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 02/06/23.
//

import SwiftUI

struct CoffeeShopCard: View {
    
    let name : String
    let rating : Float
    let city : String
    
    var body: some View {
        NavigationLink(destination: CoffeeShop(coffeeName: name, coffeeRating: rating, coffeeCity: city, category: "coffee")){
            VStack(alignment: .leading){
                Image("coffee")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 180)
                    .cornerRadius(20)
                
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                        .frame(width: 10)
                    
                    Text(String(rating))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                    Text("1200 reviews")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray)
                    
                }
                .padding(.vertical, 1)
                .padding(.horizontal, 3)
                
                Text("3.8 miles")
                    .fontWeight(.semibold)
                    .frame(alignment: .leading)
                    .foregroundColor(Color.black)
                
            }
        }
    }
}


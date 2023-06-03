//
//  CoffeeCard.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 02/06/23.
//

import SwiftUI

struct CoffeeCard: View {
    
    @EnvironmentObject private var globalState: GlobalState
    
    let id: Int
    let name : String
    let price: Int
    let description: String
    let categories: [CoffeeCategory]

    
    func addToCart(){
        globalState.cart.coffees.append(id)
        globalState.cart.total = globalState.cart.coffees.count
    }
    
    func removeFromCart(_ item: Int) {
        if let index = globalState.cart.coffees.firstIndex(of: item) {
            globalState.cart.coffees.remove(at: index)
            globalState.cart.total = globalState.cart.coffees.count
        }
    }
    
    
    var body: some View {
        HStack{
            Rectangle()
                .fill(Color("lightgray"))
                .frame(width: .infinity, height: 230)
                .cornerRadius(20)
                .overlay(
                    VStack(alignment: .leading){
                        HStack(alignment: .top){
                            Image(getCoffeeImage(categories: categories))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 100)
                                .cornerRadius(10)
                                .padding(.leading, 20)
                            
                            VStack(alignment: .leading){
                                Text(name)
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                Text(description)
                                    .font(.body)
                                    .frame(height: 50)
        
                                Text(getFormatedPrice(price: price))
                                    .fontWeight(.semibold)
                                
                                Button(action: {
                                    if globalState.cart.coffees.contains(id) {
                                        removeFromCart(id)
                                       } else {
                                           addToCart()
                                       }
                                }) {
                                    Text(globalState.cart.coffees.contains(id) ? "Remove from cart" : "Add to cart")
                                }
                                    .frame(width: 160, height: 40)
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(20)
                            }
                            .padding(.horizontal, 20)
    
                            
                        }
                    }
                )
                .overlay(
                    Image(systemName: "plus")
                        .frame(width: 30, height: 30)
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(50)
                        .offset(x: 10, y: -10)
                        
                    ,alignment: .topTrailing
                )
        }
        .padding(.horizontal, 30)
    }
}

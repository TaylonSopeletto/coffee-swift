//
//  CartView.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 29/05/23.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject private var globalState: GlobalState
    @Environment(\.presentationMode) var presentationMode
    @State var cart = CartDto(coffees: [], totalPrice: 0, productsPrice: 0, tip: 0)
    
    func getFormatedPrice(price: Int) -> String {
        let priceInDollars = Double(price) / 100.0
        let formattedPrice = String(format: "$ %.2f", priceInDollars)
        
        return formattedPrice
    }
    
    func getFormatedPriceDouble(price: Double) -> String {
        let priceInDollars = Double(price) / 100.0
        let formattedPrice = String(format: "$ %.2f", priceInDollars)
        
        return formattedPrice
    }
    
    var body: some View {
            
            ScrollView{
                Button("Go Back") {
                    presentationMode.wrappedValue.dismiss()
                }
                    .padding()
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onAppear() {
                        Api().loadProducts(ids: globalState.cart.coffees) { (cart) in
                            self.cart = cart
                        }
                    }
                VStack{
                    HStack{
                        Image(systemName: "cart")
                            .frame(width: 40, height: 40)
                            .font(.system(size: 40))
                            .overlay(
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 30)
                                    .overlay(
                                        Text(String(globalState.cart.total))
                                            .foregroundColor(Color.white)
                                    )
                                    .offset(x: 20, y: -20)
                                
                            )
                        Spacer()
                        Text("My Cart")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 100)
                    .navigationBarBackButtonHidden(true)
                    
                    
                    Text("Products:")
                        .frame(width: 170, height: 30)
                    
                    if cart.coffees.isEmpty {
                        Text("Cart is empty")
                            .font(.largeTitle)
                    } else {
                        
                        ForEach(cart.coffees) { coffee in
                            CartCoffeeCard(
                                name: coffee.name,
                                price: coffee.price,
                                categories: coffee.categories
                            )
                        }
                    }
                   
                    
                    Text("Coffees:")
                        .frame(width: 170, height: 20)
                        .padding(.top, 40)
                    Text(getFormatedPrice(price: cart.productsPrice))
                        .fontWeight(.semibold)
                        .frame(width: 170, height: 20)
                    
                    Text("Tip:")
                        .frame(width: 170, height: 20)
                    Text(getFormatedPriceDouble(price: cart.tip))
                        .fontWeight(.semibold)
                        .frame(width: 170, height: 20)
                    
                    VStack{
                        Text("Total:")
                            .frame(width: 170, height: 20)
                        
                        Text(getFormatedPrice(price: cart.totalPrice))
                            .fontWeight(.semibold)
                            .frame(width: 170, height: 20)
                        
                    }
                    .padding(.top, 40)
                    
                    
                    
                    Button(action: {}) {
                        Text("Proceed to payment")
                    }
                    .frame(width: 180, height: 40)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .padding(.top, 40)
                    
                }
            }
        
    
    }
}

struct CartCoffeeCard: View {
        
    let name : String
    let price: Int
    let categories: [CoffeeCategory]
    
    func getFormatedPrice() -> String {
        let priceInDollars = Double(price) / 100.0
        let formattedPrice = String(format: "$ %.2f", priceInDollars)
        
        return formattedPrice
    }
    
    func getCoffeeImage() -> String {
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
    
    var body: some View {
        HStack{
            Image(getCoffeeImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 90, height: 70)
                .cornerRadius(10)
                .padding(.leading, 20)
            
            VStack{
                Text(name)
                    .fontWeight(.semibold)
                    .frame(width: 100, height: 30, alignment: .leading)
                
                
                Text(getFormatedPrice())
                    .fontWeight(.semibold)
                    .frame(width: 100, height: 30, alignment: .leading)
                
            }
            .frame(width: 100, height: 70, alignment: .topLeading)
            
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView().environmentObject(GlobalState())
    }
}

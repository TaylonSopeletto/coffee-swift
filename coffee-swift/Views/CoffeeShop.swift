//
//  CoffeeShop.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 26/05/23.
//

import SwiftUI

struct CoffeeShop: View {
    
    @State var coffees = [Coffee]()
    
    func printBullshit() {
        print("print")
    }
    
    private func createGridColumns() -> [GridItem] {
        let columns = [
            GridItem()
        ]
        return columns
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVStack(alignment: .leading){
                    GeometryReader{reader in
                        Image("coffee-shop")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 250)
                        
                    }
                    .frame(height: 250)
                    .navigationBarHidden(true)
                    
                    VStack(alignment: .leading){
                        VStack(alignment: .leading){
                            Text("Haus Coffee")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            HStack{
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                                    .frame(width: 10)
                                
                                Text("4.5")
                                    .fontWeight(.semibold)
                                Text("1200 reviews")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
                                
                            }
                            .padding(.vertical, 1)
                            
                            Text("San Francisco")
                            
                        }
                        .frame(height: 150)
                        .padding(.horizontal, 40)
                        
                        
                        HStack{
                            Spacer()
                            Button(action: printBullshit) {
                                Image(systemName: "cup.and.saucer")
                                    .foregroundColor(Color.black)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(20)
                                    .font(.title)
                                    .background(Color("lightgray"))
                                    .cornerRadius(20)
                            }
                            
                            Button(action: printBullshit) {
                                Image(systemName: "takeoutbag.and.cup.and.straw")
                                    .foregroundColor(.gray)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(20)
                                    .font(.title)
                            }
                            Button(action: printBullshit) {
                                Image(systemName: "fork.knife")
                                    .foregroundColor(.gray)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(20)
                                    .font(.title)
                            }
                            Spacer()
                            
                        }
                        .padding(.bottom, 20)
                        
                        
                        LazyVGrid(columns: createGridColumns(), spacing: 40) {
                            ForEach(coffees) { coffee in
                                CoffeeCard(
                                    name: coffee.name,
                                    price: coffee.price,
                                    description: coffee.description
                                )
                            }
                        }
                        .onAppear() {
                            Api().loadData { (coffees) in
                                self.coffees = coffees
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
}

struct CoffeeCard: View {
    
    let name : String
    let price: Int
    let description: String
    
    var body: some View {
        HStack{
            Rectangle()
                .fill(Color("lightgray"))
                .frame(width: .infinity, height: 150)
                .cornerRadius(20)
                .overlay(
                    HStack{
                        Image("coffee")
                            .resizable()
                            .frame(width: 90, height: 110)
                            .cornerRadius(10)
                            .padding(.leading, 20)
                        
                        VStack(alignment: .leading){
                            Text(name)
                                .fontWeight(.semibold)
                                .font(.title3)
                            Text(description)
                                .font(.body)
                                .frame(height: 50)
    
                            Text("$ " + String(price / 100))
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal, 20)
                        .frame(height: 110)
                        
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

struct CoffeeShop_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeShop()
    }
}

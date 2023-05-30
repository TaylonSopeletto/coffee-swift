//
//  CoffeeShop.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 26/05/23.
//

import SwiftUI


struct CoffeeShop: View{
    
    @EnvironmentObject private var globalState: GlobalState
    
    let coffeeName : String
    let coffeeRating: Float
    let coffeeCity: String
    
    @State var coffees = [Coffee]()
    @State var category: String = "coffee"{
        didSet {
            loadData(for: category)
        }
    }
    
    func loadData(for category: String) {
        Api().loadData(category: category) { (coffees) in
            self.coffees = coffees
        }
    }
    
    func printBullshit() {
        print("print")
    }
    

    private func createGridColumns() -> [GridItem] {
        let columns = [
            GridItem()
        ]
        return columns
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            ScrollView{
                LazyVStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Button("Go Back") {
                            presentationMode.wrappedValue.dismiss()
                        }
                            .padding()
                            .cornerRadius(10)
                        NavigationLink(destination: CartView()){
                            Image(systemName: "cart")
                                .frame(width: 40, height: 40)
                                .font(.system(size: 40))
                                .foregroundColor(Color.black)
                                .padding(20)
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
                        }
                        
                        
                        Image("coffee-shop")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 250)
                            .navigationBarHidden(true)
                            .navigationBarTitle(Text(""), displayMode: .inline)
                            .navigationBarBackButtonHidden(true)

                
                        
                        VStack(alignment: .leading){
                            Text(coffeeName)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            HStack{
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                                    .frame(width: 10)
                                
                                Text(String(coffeeRating))
                                    .fontWeight(.semibold)
                                Text("1200 reviews")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
                                
                            }
                            .padding(.vertical, 1)
                            
                            Text(coffeeCity)
                            
                        }
                        .frame(height: 150)
                        .padding(.horizontal, 40)
                        
                        
                        HStack{
                            VStack{
                                Button(action: {category = "coffee"}) {
                                    Image(systemName: "cup.and.saucer")
                                        .foregroundColor(category == "coffee" ? Color.black : Color.gray)
                                        .frame(width: 100, height: 30)
                                        
                                        .font(.title)
                                        
                                }
                                Text("Coffee")
                                    .foregroundColor(category == "coffee" ? Color.black : Color.gray)
                                
                            }
                                .frame(height: 100)
                                .background(category == "coffee" ? Color("lightgray") : Color.white)
                                .cornerRadius(20)
                            
                            VStack{
                                Button(action: {category = "food"}) {
                                    Image(systemName: "fork.knife")
                                        .foregroundColor(category == "food" ? Color.black : Color.gray)
                                        .frame(width: 100, height: 30)
                                        
                                        .font(.title)
                                        
                                }
                                Text("Food")
                                    .foregroundColor(category == "food" ? Color.black : Color.gray)
                                
                            }
                                .frame(height: 100)
                                .background(category == "food" ? Color("lightgray") : Color.white)
                                .cornerRadius(20)
                            
                            VStack{
                                Button(action: {category = "drink"}) {
                                    Image(systemName: "takeoutbag.and.cup.and.straw")
                                        .foregroundColor(category == "drink" ? Color.black : Color.gray)
                                        .frame(width: 100, height: 30)
                                        
                                        .font(.title)
                                        
                                }
                                Text("Drink")
                                    .foregroundColor(category == "drink" ? Color.black : Color.gray)
                                
                            }
                                .frame(height: 100)
                                .background(category == "drink" ? Color("lightgray") : Color.white)
                                .cornerRadius(20)
                            
                        }
                        .padding(.bottom, 20)
                        .frame(width: UIScreen.main.bounds.width)
                        
                        
                        LazyVGrid(columns: createGridColumns(), spacing: 40) {
                            ForEach(coffees) { coffee in
                                CoffeeCard(
                                    id: coffee.id,
                                    name: coffee.name,
                                    price: coffee.price,
                                    description: coffee.description,
                                    categories: coffee.categories
                                )
                            }
                        }
                        .onAppear() {
                            Api().loadData(category: category) { (coffees) in
                                self.coffees = coffees
                            }
                        }
                    }
                }
            }
        
        
    }
}

struct CoffeeCard: View {
    
    @EnvironmentObject private var globalState: GlobalState
    
    let id: Int
    let name : String
    let price: Int
    let description: String
    let categories: [CoffeeCategory]
    
    func getFormatedPrice() -> String {
        let priceInDollars = Double(price) / 100.0
        let formattedPrice = String(format: "$ %.2f", priceInDollars)
        
        return formattedPrice
    }
    
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
            Rectangle()
                .fill(Color("lightgray"))
                .frame(width: .infinity, height: 230)
                .cornerRadius(20)
                .overlay(
                    VStack(alignment: .leading){
                        HStack(alignment: .top){
                            Image(getCoffeeImage())
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
        
                                Text(getFormatedPrice())
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

struct CoffeeShop_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeShop(coffeeName: "Preview Coffee", coffeeRating: 5, coffeeCity: "Cachoeiro de Itapemirim", category: "coffee").environmentObject(GlobalState())
    }
}

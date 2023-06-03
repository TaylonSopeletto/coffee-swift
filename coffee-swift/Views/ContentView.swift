import SwiftUI

//
//  CoffeeShop.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 26/05/23.
//

class GlobalState: ObservableObject {
    @Published var cart : Cart = Cart(coffees: [], total: 0)
}

struct ContentView: View {
    @EnvironmentObject private var globalState: GlobalState
    @State private var text: String = ""
    @State var coffeeShops = [CoffeeShopInterface]()
    
    func printBullshit() {
        print("print")
    }
    
    var body: some View {
        NavigationView{
            ScrollView {
                    HStack{
                        NavigationLink(destination: CartView()){
                            Image(systemName: "cart")
                                .frame(width: 20, height: 20)
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                            
                                .overlay(
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 30)
                                        .overlay(
                                            Text(String(globalState.cart.total))
                                                .foregroundColor(Color.white)
                                        )
                                        .offset(x: 14, y: -14)
                                )
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: LoginView()){
                            Image("person")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(50)
                        }
                    }
                    .navigationBarTitle(Text(""), displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                    
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 25)
                    VStack {
                        Text("Find a Coffee\nshop anywhere")
                            .font(.title)
                            .fontWeight(.semibold)
                            .lineLimit(nil)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 20)
                        
                        HStack {
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .padding(.leading, 20)
                                TextField("Enter text", text: $text)
                                    .padding()
                                
                            }
                            .background(Color(UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)))
                            .cornerRadius(20)
                            
                            Button(action: printBullshit) {
                                Image(systemName: "slider.horizontal.3")
                                    .foregroundColor(.white)
                                    .frame(width: 50, height: 50)
                                    .background(Color.black)
                                    .cornerRadius(20)
                            }
                        }
                        
                        Text("Featured coffee shops")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 20)
                        
                        LazyVGrid(columns: createGridColumns(), spacing: 40) {
                            ForEach(coffeeShops) { coffeeShop in
                                CoffeeShopCard(
                                    name: coffeeShop.name,
                                    rating: coffeeShop.rating,
                                    city: coffeeShop.city
                                    
                                )
                            }
                        }
                        .onAppear() {
                            Api().loadCoffeeShopsData { (coffeeShops) in
                                self.coffeeShops = coffeeShops
                            }
                        }
                            .navigationTitle("Coffee List")
                        
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
    }
    
    private func createGridColumns() -> [GridItem] {
        let columns = [
            GridItem(),
            GridItem(),
        ]
        return columns
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalState())
    }
}


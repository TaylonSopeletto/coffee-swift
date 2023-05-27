import SwiftUI

//
//  CoffeeShop.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 26/05/23.
//

struct ContentView: View {
    @State private var text: String = ""
    @State var coffeeShops = [CoffeeShopInterface]()
    
    func printBullshit() {
        print("print")
    }
    
    var body: some View {
        NavigationView{
                ScrollView {
                    VStack(alignment: .leading){
                        Image("person")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(50)
                    }
                    .navigationBarTitle("Home")
                    .navigationBarHidden(true)
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
                        }.navigationTitle("Coffee List")
                        
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
        ContentView()
    }
}

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

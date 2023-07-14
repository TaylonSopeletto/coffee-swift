//
//  PaymentView.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 03/06/23.
//

import SwiftUI

struct PaymentView: View {
    
    @EnvironmentObject private var globalState: GlobalState
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            Button("Go Back") {
                presentationMode.wrappedValue.dismiss()
            }
                .padding()
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                Image(systemName: "cart")
                    .frame(width:0, height: 40)
                    .font(.system(size: 30))
                    .foregroundColor(Color.black)
                    .padding(20)
                    .overlay(
                        Circle()
                            .fill(Color.red)
                            .frame(width: 25)
                            .overlay(
                                Text(String(globalState.cart.total))
                                    .foregroundColor(Color.white)
                            )
                            .offset(x: 14, y: -14)
                        
                    )
                Spacer()
                Text("Payment")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
            .navigationBarBackButtonHidden(true)
            
            Text("Please, select your payment method:")
                .padding(.bottom, 30)
            HStack{
                VStack{
                    Button(action: {print("123")}) {
                        Image(systemName: "creditcard")
                            .foregroundColor(Color.black)
                            .frame(width: 130, height: 30)
                            .font(.title)
                            
                    }
                    Text("Credit Card")
                        .foregroundColor(Color.black)
                    
                }
                    .frame(height: 100)
                    .background(Color("lightgray"))
                    .cornerRadius(20)
                
                VStack{
                    Button(action: {print("123")}) {
                        Image(systemName: "dollarsign")
                            .foregroundColor(Color.gray)
                            .frame(width: 130, height: 30)
                            
                            .font(.title)
                            
                    }
                    Text("Money")
                        .foregroundColor(Color.gray)
                    
                }
                    .frame(height: 100)
                    .background(Color.white)
                    .cornerRadius(20)
            
                
            }
            .padding(.horizontal, 3)
            
            Button(action: {}) {
                Text("Continue")
            }
            .frame(width: 180, height: 40)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(20)
            .padding(.top, 40)
        }
        
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView().environmentObject(GlobalState())
    }
}

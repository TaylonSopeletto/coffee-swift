//
//  LoginView.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 27/05/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var username : String = ""
    @State var password : String = ""
    
    func login(){
        print("do login")
    }
    
    var body: some View {
        VStack{
            Image(systemName: "cup.and.saucer")
                .font(.system(size: 50))
            Text("Swift Coffee")
                .font(.title)
                .fontWeight(.semibold)
            
            VStack{
                TextField("username", text: $username)
                    .padding()
                    .background(Color("lightgray"))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                
                TextField("password", text: $password)
                    .padding()
                    .background(Color("lightgray"))
                    .cornerRadius(10)
            }
                .padding(.vertical, 50)
            
            Button(action: login) {
                Text("Login")
            }
                .frame(width: 100, height: 40)
                .background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(20)
        }
        .padding(.horizontal, 30)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

//
//  coffee_swiftApp.swift
//  coffee-swift
//
//  Created by Taylon L. Sopeletto on 24/05/23.
//

import SwiftUI

@main
struct coffee_swiftApp: App {
    
    let globalState = GlobalState()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(globalState)
        }
    }
}

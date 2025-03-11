//
//  ContentView.swift
//  in-app-purchase-demo
//
//  Created by Felicia Graciella on 04/03/25.
//

import SwiftUI
//import StoreKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("In-App Purchase Demo")
                
                List {
                    NavigationLink(destination: FreeView()) {
                        Text("Free")
                    }
                    
                    NavigationLink(destination: PremiumView()) {
                        Text("Pro")
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: StoreView()) {
                    Text("Store")
                }
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .topLeading)
            .padding()
            .navigationTitle("Store")
        }
        .environmentObject(EntitlementManager())
        .environmentObject(SubscriptionsManager(entitlementManager: EntitlementManager()))
    }
}

//#Preview {
//    ContentView()
//}

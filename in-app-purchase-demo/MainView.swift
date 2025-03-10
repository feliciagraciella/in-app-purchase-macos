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
                        Text("Page 1")
                    }
                    
                    NavigationLink(destination: PremiumView()) {
                        Text("Page 2")
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
    
    private var premiumView: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "dollarsign.circle.fill")
                .foregroundStyle(.tint)
                .font(Font.system(size: 80))
            
            Text("Unlock Pro Access")
                .font(.system(size: 33.0, weight: .bold))
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
            
            Text("Get access to all of our features")
                .font(.system(size: 17.0, weight: .semibold))
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
    }
}

//#Preview {
//    ContentView()
//}

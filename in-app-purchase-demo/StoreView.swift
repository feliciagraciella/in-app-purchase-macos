//
//  StorePage.swift
//  in-app-purchase-demo
//
//  Created by Felicia Graciella on 04/03/25.
//

import SwiftUI
import StoreKit

struct StoreView: View {
    @EnvironmentObject var entitlementManager: EntitlementManager
    @EnvironmentObject var subscriptionsManager: SubscriptionsManager
    
    @State private var selectedProduct: Product? = nil
    private let features: [String] = ["Remove all ads", "Daily new content", "Other cool features", "Follow for more tutorials"]
    
    var body: some View {
        VStack(alignment: .center, spacing: 12.5) {
            if !subscriptionsManager.products.isEmpty {
                Spacer()
                
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
                
                List(features, id: \.self) { feature in
                    HStack(alignment: .center) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 22.5, weight: .medium))
                            .foregroundStyle(.blue)
                        
                        Text(feature)
                            .font(.system(size: 17.0, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.leading)
                    }
                    .listRowSeparator(.hidden)
                    .frame(height: 35)
                }
                .scrollDisabled(true)
                .listStyle(.plain)
                .padding(.vertical, 20)
                
                VStack(spacing: 2.5) {
                    List(subscriptionsManager.products, id: \.self) { product in
                        SubscriptionItemView(product: product, selectedProduct: $selectedProduct)
                    }
                    .scrollDisabled(true)
//                    .listStyle(.plain)
//                    .listRowSpacing(2.5)
                    .frame(height: CGFloat(subscriptionsManager.products.count) * 90, alignment: .bottom)
                    
                    VStack(alignment: .center, spacing: 15) {
                        Button(action: {
                            if let selectedProduct = selectedProduct {
                                Task {
                                    await subscriptionsManager.buyProduct(selectedProduct)
                                }
                            } else {
                                print("Please select a product before purchasing.")
                            }
                        }) {
                            RoundedRectangle(cornerRadius: 12.5)
                                .overlay {
                                    Text("Purchase")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 16.5, weight: .semibold, design: .rounded))
                                }
                        }
                        .padding(.horizontal, 20)
                        .frame(height: 46)
                        .disabled(selectedProduct == nil)
                        
                        Button("Restore Purchases") {
                            Task {
                                await subscriptionsManager.restorePurchases()
                            }
                        }
                        .font(.system(size: 14.0, weight: .regular, design: .rounded))
                        .frame(height: 15, alignment: .center)
                    }
                }
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5)
                    .ignoresSafeArea(.all)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .onAppear {
            Task {
                await subscriptionsManager.loadProducts()
            }
        }
        
    }
}

struct SubscriptionItemView: View {
    var product: Product
    @Binding var selectedProduct: Product?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12.5)
                .stroke(selectedProduct == product ? .blue : .black, lineWidth: 1.0)
//                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            
            HStack {
                VStack(alignment: .leading, spacing: 8.5) {
                    Text(product.displayName)
                        .font(.system(size: 16.0, weight: .semibold, design: .rounded))
                        .multilineTextAlignment(.leading)
                    
                    Text("Get full access for just \(product.displayPrice)")
                        .font(.system(size: 14.0, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                Image(systemName: selectedProduct == product ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(selectedProduct == product ? .blue : .gray)
            }
            .padding(.horizontal, 20)
            .frame(height: 65, alignment: .center)
        }
        .onTapGesture {
            selectedProduct = product
        }
        .listRowSeparator(.hidden)
    }
}


#Preview {
    StoreView()
        .environmentObject(EntitlementManager())
        .environmentObject(SubscriptionsManager(entitlementManager: EntitlementManager()))
}

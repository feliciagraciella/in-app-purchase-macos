//
//  PremiumView.swift
//  in-app-purchase-demo
//
//  Created by Felicia Graciella on 04/03/25.
//

import SwiftUI

struct PremiumView: View {
    var body: some View {
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

#Preview {
    PremiumView()
}

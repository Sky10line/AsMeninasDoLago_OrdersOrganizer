//
//  BigButtonVariant.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 26/10/21.
//

import SwiftUI

struct BigButtonVariant: View {
    let text: String
    let action: (() -> Void)?
    @State private var tap: Bool = false
    var body: some View {
        ZStack {
            Button(action: {
                tap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    tap = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    action?()
                }
            }, label: {
                HStack {
                    Text(text)
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(Color(UIColor.appGreen))
                        .padding()
                }.frame(maxWidth: .infinity)
            }).background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 21).stroke(Color(UIColor.appGreen), lineWidth: 3))
            .cornerRadius(20)
            .shadow(radius: tap ? 1 : 2)
            .animation(.spring(response: 0.6, dampingFraction: 1))
            .padding()
        }.scaleEffect(tap ? 0.9 : 1)
        .animation(.spring(response: 0.6, dampingFraction: 1))
            
    }
}

struct BigButtonVariant_Previews: PreviewProvider {
    static var previews: some View {
        BigButtonVariant(text: "Nova Comanda", action: nil)
    }
}

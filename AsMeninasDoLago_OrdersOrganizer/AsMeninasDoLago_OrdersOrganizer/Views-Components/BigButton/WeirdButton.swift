//
//  WeirdButton.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 12/11/21.
//

import SwiftUI

struct WeirdButton: View {
    let text: String
    let action: (() -> Void)?
    let total: Double
    @State private var tap: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.appGreen))
                .shadow(radius: tap ? 1 : 4)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .animation(.spring(response: 0.6, dampingFraction: 1))
            
            VStack {
                Capsule()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 5, alignment: .center)
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
                            .foregroundColor(.white)
                            .padding()
                    }.frame(maxWidth: .infinity)
                })
                
            }
            Text("\(total.asCurrencyBR() ?? 0.00.asCurrencyBR()!)")
                .fontWeight(.light)
                .font(.title3)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 100, alignment: .trailing)
                .padding(.horizontal)
                .offset(y: 5)
        }
        .scaleEffect(tap ? 0.9 : 1)
        .animation(.spring(response: 0.6, dampingFraction: 1))
            
    }
    
    
}

struct WeirdButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            WeirdButton(text: "Comanda", action: nil, total: 0.00)
        }
    }
}

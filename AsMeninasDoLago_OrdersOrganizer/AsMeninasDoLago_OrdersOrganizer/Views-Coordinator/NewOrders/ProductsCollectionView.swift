//
//  ProductsCollectionView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Felipe Ferreira on 14/10/21.
//

import Foundation
import SwiftUI

struct ProductsCollectionView: View {
    let data: Array<ProductJSON>
    
    let layout = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 16) {
                ForEach(data, id: \.self ) { item in
                    VStack {
                        Image("food")
                            .resizable()
                            .frame(width: 187, height: 130)
                        if let name = item.name {
                            HStack {
                                Text(name)
                            }
                            .multilineTextAlignment(.trailing)
                            .padding(.horizontal)
                            Spacer()
                        }
                        
                        Spacer(minLength: 53)
                        
                        if let price = item.price {
                            HStack {
                                Text(price.asCurrencyBR() ?? 0.00.asCurrencyBR()!)
                            }
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                            Spacer()
                        }
                        
                        
                    }.background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    
                }
            } .padding()
        }
    }
}

struct ProductsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        let products = [
            ProductJSON(name: "Hot-Dog", price: 10.00),
            ProductJSON(name: "Refrigerante", price: 05.00),
            ProductJSON(name: "Hamburger", price: 15.00)
        ]
        ProductsCollectionView(data: products)
    }
}


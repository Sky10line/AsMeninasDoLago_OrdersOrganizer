//
//  OrderCollectionCell.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 16/11/21.
//

import SwiftUI

struct OrderCollectionCell: View {
    @Binding var selectedModal: ContentView.Modals
    var item: OrderItem
    
    var body: some View {
        VStack {
            HStack {
                Text("\(item.quantity)")
                    .fontWeight(.bold)
                    .font(.title)
                    + Text("x")
                    .fontWeight(.light)
                
                Image(item.item.image ?? "LanchePlaceHolder")
                    .resizable()
                    .scaledToFit()
                    .frame(minHeight: 50, idealHeight: 75, maxHeight: 75)
                
                VStack (alignment: .leading, spacing: 5) {
                    Text(item.item.name)
                        .fontWeight(.bold)
                        .lineLimit(3)
                    
                    Text (item.item.price.asCurrencyBR() ?? 0.00.asCurrencyBR()!)
                        .padding(.top)
                }
                
                Spacer()
                
                if selectedModal == ContentView.Modals.homeOrderDetails {
                    HStack {
                        Button(action: {
                            print("Editar")
                        }) {
                            Image(systemName: "pencil")
                                .renderingMode(.template)
                                .foregroundColor(.black)
                                .font(.title)
                                
                        }
                        .padding(3)
                        
                        Button(action: {
                            print("Excluir")
                        }){
                            Image(systemName: "trash")
                                .renderingMode(.template)
                                .foregroundColor(.red)
                                .font(.title2)
                                
                        }
                        .padding(3)
                        
                    } // Fecha HStack dos botões de ação
                } // Fecha if
                
            }
            .padding(.vertical, 10)
            
            Divider()
            
        }
        .padding(.horizontal, 20)
    }
}

struct OrderCollectionCell_Previews: PreviewProvider {
    static var previews: some View {
        OrderCollectionCell(selectedModal: .constant(ContentView.Modals.homeOrderDetails), item: dummyItens2[0])
    }
}

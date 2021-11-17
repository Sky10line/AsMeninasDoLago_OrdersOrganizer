//
//  OrderCollectionCell.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 16/11/21.
//

import SwiftUI

struct OrderCollectionCell: View {
    @Binding var selectedModal: ContentView.Modals
    var item: testData
    
    var body: some View {
        VStack {
            HStack {
                Text(item.qtd)
                    .fontWeight(.bold)
                    .font(.title)
                    + Text("x")
                    .fontWeight(.light)
                
                Image(systemName: item.img)
                    .resizable()
                    .scaledToFit()
                    .frame(minHeight: 50, idealHeight: 75, maxHeight: 75)
                //.frame(height: 75)
                
                VStack (alignment: .leading, spacing: 5) {
                    Text(item.nome)
                        .fontWeight(.bold)
                        .lineLimit(3)
                    
                    Text (item.preco.asCurrencyBR() ?? 0.00.asCurrencyBR()!)
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
        OrderCollectionCell(selectedModal: .constant(ContentView.Modals.finishedOrderDetails), item: testData(img: "circle", nome: "Carne Louca", preco: 22, qtd: "3"))
    }
}
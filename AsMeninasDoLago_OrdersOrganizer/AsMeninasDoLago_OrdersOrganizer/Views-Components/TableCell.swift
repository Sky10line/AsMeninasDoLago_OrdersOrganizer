//
//  TableCell.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 26/10/21.
//

import SwiftUI

struct TableCell: View {
    var item: NewOrderItem
    
    var body: some View {
        VStack {
            HStack {
                // Quantidade
                Text("\(item.quantity)")
                    .fontWeight(.bold)
                    .font(.title)
                + Text("x")
                    .fontWeight(.light)

                // Imagem
                Image(item.item.image ?? "LanchePlaceHolder")
                    .resizable()
                    .scaledToFit()
                    .frame(minHeight: 50, idealHeight: 75, maxHeight: 75)
                    //.frame(height: 75)
                
                VStack (alignment: .leading, spacing: 5) {
                    // Nome do item
                    Text(item.item.name ?? "Item")
                        .fontWeight(.bold)
                        .lineLimit(3)
                    
                    // Preço do item
                    Text ((item.item.price ?? 0.00).asCurrencyBR() ?? 0.00.asCurrencyBR()!)
                        .padding(.top)
                }
                
                // Pra encostar os botões no canto
                Spacer()
                
                // Botões de ação
                HStack {
                    // Botão de editar
                    Button(action: {
                        print("Editar")
                    }) {
                        Image(systemName: "pencil")
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .font(.title)
                            
                    }
                    .padding(3)
                    
                    // Botão de deletar
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

            } // Fecha HStack de tudo
            .padding(.vertical, 10)
            
            Divider() // Divisória entre células
            
        } // Fecha VStack de geral + divisória
        .padding(.horizontal, 20)
    } // Fecha body
} // Fecha struct

//struct TableCell_Previews: PreviewProvider {
//    static var previews: some View {
//        TableCell(item: testData(img: "circle", nome: "Carne Louca", preco: 22, qtd: "3"))
//    }
//}
